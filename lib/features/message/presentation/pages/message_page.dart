import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }


// lib/features/messages/presentation/screens/chat_screen.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/presentation/bloc/chat/chat_cubit.dart';
import 'package:real_estate/service_locator.dart';

class MessagePage extends StatefulWidget {
  final int? conversationId;
  final String ownerName;
  final int propertyId;
  final String receiverId;
  

  const MessagePage({
    super.key,
    required this.ownerName,
    required this.propertyId,
    this.conversationId, required this.receiverId,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final ChatCubit _chatCubit;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _chatCubit = ChatCubit(
      getMessagesUseCase: sl(),
      sendMessageUseCase: sl(),
      markAsReadUseCase: sl(),
      findConversationIdUseCase: sl(),
      propertyId: widget.propertyId,
      receiverId: widget.receiverId,
      conversationId: widget.conversationId,
    )..loadMessages();
    
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatCubit.close();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSendPressed() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _chatCubit.sendMessage(
      receiverId: widget.receiverId,
      content: text,
      propertyId: widget.propertyId,
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatCubit,
      child: Scaffold(    
        backgroundColor: AppColors.thirdColor,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PropertyDetailsPage(property: ,)));
            },
            child: Icon(CupertinoIcons.arrow_left,color: Colors.white,)),
          backgroundColor: AppColors.primaryColor,
          title: CustomText(
            text: widget.ownerName,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatLoaded || state is ChatSendError) {
                    _scrollToBottom();
                  }
                  if (state is ChatSendError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoading || state is ChatInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ChatError) {
                    return Center(
                      child: CustomText(
                        text: state.message,
                        color: AppColors.dangerColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }

                  final messages = state is ChatLoaded
                      ? state.messages
                      : (state as ChatSendError).messages;

                  if (messages.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: 'ابدأ المحادثة الآن',
                        color: AppColors.grayColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                       final message = messages[index];
                       final isMine = message.senderId.toString() != widget.receiverId;
                       return  _MessageBubble(message: message,isMine: isMine,);
                    }
                       
                  );
                },
              ),
            ),
            _MessageInputBar(
              controller: _messageController,
              onSend: _onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isMine;

  const _MessageBubble({
    required this.message,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMine ? AppColors.primaryColor : AppColors.secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isMine ? 14 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 14),
          ),
        ),
        child: CustomText(
          text: message.content,
          color: isMine ? Colors.white : AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'اكتب رسالتك...',
                  filled: true,
                  fillColor: AppColors.textFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                onPressed: onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}