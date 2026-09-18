import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/notification/data/models/notification_model.dart';
import 'package:real_estate/service_locator.dart';

abstract class NotificationApiService {
Future<Either<Failure, List<NotificationModel>>> getAllNotifications();

}

class NotificationApiServiceImp extends NotificationApiService{
  @override
  Future<Either<Failure, List<NotificationModel>>> getAllNotifications() async {
  try {
      final response = await sl<DioClient>().get(ApiUrls.notifications);

      final List<dynamic> data = response.data as List<dynamic>;
      final notifications = data
          .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(notifications);
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : (e.message ?? 'Unknown error');
      return Left(ServerFailure(message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
