import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/notification/domain/entities/notification_entity.dart';
import 'package:real_estate/features/notification/domain/repository/notification_repo.dart';
import 'package:real_estate/service_locator.dart';


class NotificationUseCase implements UseCase<Either<Failure, List<NotificationEntity>>, void> {
  @override
  Future<Either<Failure, List<NotificationEntity>>> call({void param}) async {
    return sl<NotificationRepository>().getAllNotification();
  }
}