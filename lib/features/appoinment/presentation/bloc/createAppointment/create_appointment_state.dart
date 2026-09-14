part of 'create_appointment_cubit.dart';



abstract class CreateappointmentState extends Equatable {
  const CreateappointmentState();

  @override
  List<Object?> get props => [];
}

class CreateappointmentInitial extends CreateappointmentState {}

class CreateappointmentLoading extends CreateappointmentState {}

class CreateappointmentLoaded extends CreateappointmentState {
  final Appointment appointment;

  const CreateappointmentLoaded(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class CreateappointmentError extends CreateappointmentState {
  final String message;

  const CreateappointmentError(this.message);

  @override
  List<Object?> get props => [message];
}