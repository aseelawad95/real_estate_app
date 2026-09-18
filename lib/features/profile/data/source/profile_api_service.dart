import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/core/constants/api_urls.dart';

import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/profile/data/models/user_model.dart';
import 'package:real_estate/service_locator.dart';



abstract class ProfileApiService {
  Future<Either<Failure, UserModel>> getUserById(String userId);
  Future<Either<Failure, UserModel>> editUser(String userId, UserModel user);
}

class ProfileApiServiceImp extends ProfileApiService{
 @override
 Future<Either<Failure, UserModel>> getUserById(String userId) async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.userByUserId(userId));
      debugPrint("userId : $userId");
      debugPrint('Response data: ${response.data}');

   final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final UserModel user = UserModel.fromJson(data);

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

@override
  Future<Either<Failure, UserModel>> editUser(String userId, UserModel user) async {
    try {
      final response = await sl<DioClient>().patch(
        ApiUrls.editUserByUserId(userId),
        data: user.toJson(),
      );
      print('Edit user response data: ${response.data}');

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