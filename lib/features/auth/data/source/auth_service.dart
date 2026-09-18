import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/auth/data/models/login_model.dart';
import 'package:real_estate/features/auth/data/models/send_sode_model.dart';
import 'package:real_estate/features/auth/data/models/signup_model.dart';
import 'package:real_estate/features/auth/data/models/verify_code_model.dart';
import 'package:real_estate/service_locator.dart';

abstract class AuthApiService {

  Future<Either> signup(SignupModel signupReq);
  // Future<Either> getUser();
  Future<Either> signin(LoginModel loginReq);
  Future<Either> sendCode(SendCodeModel sendCode);
    Future<Either> verifyCode(VerifyCodeModel sendCode);
} 


class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<dynamic, dynamic>> signin(LoginModel loginReq) async {
    try {
     var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: loginReq.toMap()
      );
        
      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }
  
  @override
  Future<Either<dynamic, dynamic>> signup(SignupModel signupReq) async {
   try {
     var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: signupReq.toMap()
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either<dynamic, dynamic>> sendCode(SendCodeModel sendCode) async {
    try {
     var response = await sl<DioClient>().post(
        ApiUrls.sendCode,
        data: sendCode.toMap()
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either<dynamic, dynamic>> verifyCode(VerifyCodeModel sendCode) async {
     try {
     var response = await sl<DioClient>().post(
        ApiUrls.verifyCode,
        data: sendCode.toMap()
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }

}


