part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;
  final bool isSending;

  const ChatLoaded({required this.messages, this.isSending = false});

  @override
  List<Object> get props => [messages, isSending];
}

class ChatSendError extends ChatState {
  final List<MessageEntity> messages;
  final String message;

  const ChatSendError({required this.messages, required this.message});

  @override
  List<Object> get props => [messages, message];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}