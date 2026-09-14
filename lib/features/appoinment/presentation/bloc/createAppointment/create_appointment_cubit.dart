import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/appoinment/domain/entities/appointment.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';
import 'package:real_estate/features/appoinment/domain/usecase/create_appointment_usecase.dart';

part 'create_appointment_state.dart';

class CreateappointmentCubit extends Cubit<CreateappointmentState> {
  final CreateAppointmentUseCase createAppointmentUseCase;

  CreateappointmentCubit(this.createAppointmentUseCase) : super(CreateappointmentInitial());

  Future<void> createAppointment(CreateAppointment params) async {
    emit(CreateappointmentLoading());

    final result = await createAppointmentUseCase.call(param: params);

    result.fold(
      (failure) => emit(CreateappointmentError(failure.message.toString())),
      (appointment) => emit(CreateappointmentLoaded(appointment)),
    );
  }
}