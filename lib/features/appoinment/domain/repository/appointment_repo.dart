import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/appoinment/domain/entities/appointment.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';

abstract class AppointmentRepo {
    Future<Either<Failure, Appointment>> createAppointment(CreateAppointment createAppointment);


}


