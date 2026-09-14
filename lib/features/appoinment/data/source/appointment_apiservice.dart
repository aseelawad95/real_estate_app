import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/appoinment/data/models/appointment_model.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';
import 'package:real_estate/service_locator.dart';

abstract class AppointmentApiservice {
  Future<Either<Failure, AppointmentModel>> createAppointment(CreateAppointment createAppointment);

}

class AppointmentApiserviceImpl extends AppointmentApiservice{
  @override
  Future<Either<Failure, AppointmentModel>> createAppointment(CreateAppointment createAppointment) async {
    try {
      final response = await sl<DioClient>().post(
      ApiUrls.appointment,
      data: createAppointment.toJson(),
    );

    debugPrint("STATUS CODE: ${response.statusCode}");
    debugPrint("SUCCESS DATA: ${response.data}");  

    final AppointmentModel appointment = AppointmentModel.fromJson(response.data);
 
    return Right(appointment);
    } on DioException catch (e) {
      debugPrint("STATUS: ${e.response?.statusCode}");
      debugPrint("HEADERS: ${e.response?.headers}");
      debugPrint("DATA TYPE: ${e.response?.data.runtimeType}");
      debugPrint("DATA RAW: ${e.response?.data}");
      debugPrint("REQUEST HEADERS: ${e.requestOptions.headers}");
      debugPrint("REQUEST CONTENT-TYPE: ${e.requestOptions.contentType}");

      final message = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Unknown error')
          : (e.response?.data?.toString().isNotEmpty == true
              ? e.response!.data.toString()
              : 'Unknown error');
      return Left(ServerFailure(message));
    } catch (e, stack) {
      debugPrint("GENERIC ERROR: $e");
      debugPrint("STACK TRACE: $stack");
      return Left(ServerFailure(e.toString()));
    }
  
  }

}