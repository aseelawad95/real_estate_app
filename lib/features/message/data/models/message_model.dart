import 'package:real_estate/features/message/domain/entities/message_entity.dart';

class MessageModel {
  final int id;
  final int conversationId;
  final String senderId;
  final String senderName;
  final String content;
  final bool isRead;
  final DateTime? sentAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.isRead,
    this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? 0,
      conversationId: json['conversationId'] ?? 0,
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      content: json['content'] ?? '',
      isRead: json['isRead'] ?? false,
      sentAt: json['sentAt'] != null ? DateTime.tryParse(json['sentAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'isRead': isRead,
      'sentAt': sentAt?.toIso8601String(),
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      content: content,
      isRead: isRead,
      sentAt: sentAt,
    );
  }
}