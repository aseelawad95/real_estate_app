import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String title;
  final String message;
  final int type;
  final bool isRead;
  final DateTime? createdOn;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    this.createdOn,
  });

  @override
  List<Object?> get props => [id, title, message, type, isRead, createdOn];
}