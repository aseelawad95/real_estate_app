import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/notification/domain/entities/notification_entity.dart';


abstract class NotificationRepository {
    Future<Either<Failure, List<NotificationEntity>>> getAllNotification();
    
}