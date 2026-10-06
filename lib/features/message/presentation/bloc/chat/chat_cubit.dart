import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/features/message/domain/entities/find_conversation.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/domain/entities/send_message.dart';
import 'package:real_estate/features/message/domain/usecase/find_conversation_usecase.dart';
import 'package:real_estate/features/message/domain/usecase/get_conversation_message.dart';
import 'package:real_estate/features/message/domain/usecase/mark_read_usecase.dart';
import 'package:real_estate/features/message/domain/usecase/send_message_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetConversationMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final FindConversationIdUseCase findConversationIdUseCase;
  final int propertyId;
  final String receiverId;

  int? _conversationId;

  ChatCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.markAsReadUseCase,
    required this.findConversationIdUseCase,
    required this.propertyId,
    required this.receiverId,
    int? conversationId,
  })  : _conversationId = conversationId,
        super(ChatInitial());

  Future<void> loadMessages() async {
  emit(ChatLoading());

  if (_conversationId == null) {
    final found = await findConversationIdUseCase.call(
      param: FindConversationParams(
        propertyId: propertyId,
        otherUserId: receiverId,
      ),
    );

    String? error;
    found.fold(
      (failure) => error = failure.message.toString(),
      (id) => _conversationId = id,
    );

    if (error != null) {
      emit(ChatError(error!));
      return;
    }

    if (_conversationId == null) {
      debugPrint(
        '[Chat] propertyId=$propertyId receiverId=$receiverId conversationId=null (no conversation yet)',
      );
      emit(const ChatLoaded(messages: []));
      return;
    }
  }

  debugPrint(
    '[Chat] propertyId=$propertyId receiverId=$receiverId conversationId=$_conversationId',
  );

  final result = await getMessagesUseCase.call(param: _conversationId);

  await result.fold(
    (failure) async => emit(ChatError(failure.message.toString())),
    (messages) async {
      debugPrint('[Chat] loaded ${messages.length} messages');
      emit(ChatLoaded(messages: messages));
      await markAsReadUseCase.call(param: _conversationId);
    },
  );
}

  Future<void> sendMessage({
    required String content,
    required int propertyId,
    required String receiverId,
  }) async {
    final currentMessages = state is ChatLoaded
        ? (state as ChatLoaded).messages
        : <MessageEntity>[];

    emit(ChatLoaded(messages: currentMessages, isSending: true));

    final params = SendMessageParams(
      receiverId: receiverId,
      content: content,
      conversationId: _conversationId,
      propertyId: _conversationId == null ? propertyId : null,
    );

    final result = await sendMessageUseCase.call(param: params);

    result.fold(
      (failure) => emit(ChatSendError(
        messages: currentMessages,
        message: failure.message.toString(),
      )),
      (sentMessage) {
        _conversationId = sentMessage.conversationId;
        emit(ChatLoaded(messages: [...currentMessages, sentMessage]));
      },
    );
  }
}