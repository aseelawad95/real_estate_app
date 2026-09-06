import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';

import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/profile/data/models/user_model.dart';
import 'package:real_estate/service_locator.dart';



abstract class ProfileApiService {
  Future<Either<Failure, UserModel>> getUserById(String userId);
}

class ProfileApiServiceImp extends ProfileApiService{
 @override
 Future<Either<Failure, UserModel>> getUserById(String userId) async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.userByUserId(userId));
      print('Response data: ${response.data}');

      final List<dynamic> dataList = response.data as List<dynamic>;
      print('🔥 First item: ${dataList.first}');
      final UserModel user = UserModel.fromJson(dataList.first as Map<String, dynamic>);

      return Right(user);
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