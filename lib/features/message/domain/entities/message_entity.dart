import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int id;
  final int conversationId;
  final String senderId;
  final String senderName;
  final String content;
  final bool isRead;
  final DateTime? sentAt;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.isRead,
    this.sentAt,
  });

  @override
  List<Object?> get props =>
      [id, conversationId, senderId, senderName, content, isRead, sentAt];
}