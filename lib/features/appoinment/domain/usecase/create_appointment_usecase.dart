import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/appoinment/domain/entities/appointment.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';
import 'package:real_estate/features/appoinment/domain/repository/appointment_repo.dart';
import 'package:real_estate/service_locator.dart';

class CreateAppointmentUseCase implements UseCase<Either<Failure, Appointment>, CreateAppointment> {
  @override
  Future<Either<Failure, Appointment>> call({CreateAppointment? param}) async {
    return sl<AppointmentRepo>().createAppointment(param!);
  }
}