import 'package:real_estate/features/message/domain/entities/conversation_entity.dart';

class ConversationModel {
  final int id;
  final int? propertyId;
  final String otherUserId;
  final String otherUserName;
  final DateTime? lastMessageAt;
  final int unreadCount;

  ConversationModel({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.unreadCount,
    this.propertyId,
    this.lastMessageAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? 0,
      propertyId: json['propertyId'],
      otherUserId: json['otherUserId'] ?? '',
      otherUserName: json['otherUserName'] ?? 'مستخدم',
      unreadCount: json['unreadCount'] ?? 0,
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.tryParse(json['lastMessageAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      'unreadCount': unreadCount,
      'lastMessageAt': lastMessageAt?.toIso8601String(),
    };
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      propertyId: propertyId,
      otherUserId: otherUserId,
      otherUserName: otherUserName,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
    );
  }
}