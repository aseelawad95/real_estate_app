import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/notification/domain/entities/notification_entity.dart';
import 'package:real_estate/features/notification/domain/usecase/get_all_notification_usecase.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
   final NotificationUseCase notificationUseCase;
  GetNotificationCubit(this.notificationUseCase) : super(GetNotificationInitial());

 

  Future<void> getAllNotification() async {
    emit(GetNotificationLoading());

    final result = await notificationUseCase.call();

    result.fold(
      (failure) => emit(GetNotificationError(failure.message.toString())),
      (property) => emit(GetNotificationLoaded(property)),
    );
  }
}
