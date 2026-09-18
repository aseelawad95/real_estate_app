part of 'get_notification_cubit.dart';

abstract class GetNotificationState extends Equatable {
  const GetNotificationState();

  @override
  List<Object?> get props => [];
}

class GetNotificationInitial extends GetNotificationState {}


class GetNotificationLoading extends GetNotificationState {}

class GetNotificationLoaded extends GetNotificationState {
  final List<NotificationEntity> notification;

  const GetNotificationLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class GetNotificationError extends GetNotificationState {
  final String message;

  const GetNotificationError(this.message);

  @override
  List<Object?> get props => [message];
}