import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/notification/data/source/notification_apiservice.dart';
import 'package:real_estate/features/notification/domain/entities/notification_entity.dart';
import 'package:real_estate/features/notification/domain/repository/notification_repo.dart';

class  NotificationRepositoryImpl extends  NotificationRepository {
   final  NotificationApiService notificationApiService;
  
NotificationRepositoryImpl(this.notificationApiService);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() async {
    final result = await notificationApiService.getAllNotifications();
  
   return result.fold(
      (failure) => Left(failure),
      (propertyModels) {
        final notifications = propertyModels.map((model) => model.toEntity()).toList();
        return Right(notifications); 
      },
    );
  }


}