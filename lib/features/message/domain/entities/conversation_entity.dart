import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  final int id;
  final int? propertyId;
  final String otherUserId;
  final String otherUserName;
  final DateTime? lastMessageAt;
  final int unreadCount;

  const ConversationEntity({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.unreadCount,
    this.propertyId,
    this.lastMessageAt,
  });

  @override
  List<Object?> get props =>
      [id, propertyId, otherUserId, otherUserName, lastMessageAt, unreadCount];
}