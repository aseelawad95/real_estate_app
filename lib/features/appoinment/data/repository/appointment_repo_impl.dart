import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/appoinment/data/source/appointment_apiservice.dart';
import 'package:real_estate/features/appoinment/domain/entities/appointment.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';
import 'package:real_estate/features/appoinment/domain/repository/appointment_repo.dart';

class AppointmentRepoImpl extends AppointmentRepo {
  final AppointmentApiservice appointmentApiService;
  AppointmentRepoImpl(this.appointmentApiService);

  @override
  Future<Either<Failure, Appointment>> createAppointment(CreateAppointment createAppointment) async {
    final result = await appointmentApiService.createAppointment(createAppointment);

    return result.fold(
      (failure) => Left(failure),
      (appointmentModel) {
        final entity = appointmentModel.toEntity();
        return Right(entity);
      },
    );
  }
}