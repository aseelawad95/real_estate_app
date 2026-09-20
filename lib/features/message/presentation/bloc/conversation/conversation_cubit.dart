import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/message/domain/entities/conversation_entity.dart';
import 'package:real_estate/features/message/domain/usecase/get_conversation_usecase.dart';

part 'conversation_state.dart';

class ConversationsCubit extends Cubit<ConversationState> {
  final GetConversationsUseCase getConversationsUseCase;

  ConversationsCubit(this.getConversationsUseCase) : super(ConversationInitial());

  Future<void> loadConversations() async {
    emit(ConversationsLoading());

    final result = await getConversationsUseCase.call();

    result.fold(
      (failure) => emit(ConversationsError(failure.message.toString())),
      (conversations) => emit(ConversationsLoaded(conversations)),
    );
  }
}