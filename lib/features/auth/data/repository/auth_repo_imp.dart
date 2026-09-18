import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/features/auth/data/models/login_model.dart';
import 'package:real_estate/features/auth/data/models/send_sode_model.dart';
import 'package:real_estate/features/auth/data/models/signup_model.dart';
import 'package:real_estate/features/auth/data/models/verify_code_model.dart';
import 'package:real_estate/features/auth/data/source/auth_service.dart';
import 'package:real_estate/features/auth/data/source/notification_apiservice.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
Future<Either<dynamic, dynamic>> signin(LoginModel loginReq) async {
  final Either result = await sl<AuthApiService>().signin(loginReq);

  if (result.isLeft()) {
    return Left(result.swap().getOrElse(() => 'Unknown error'));
  }

  final Response? response = result.getOrElse(() => null) as Response?;
  if (response == null) {
    return Left('Empty response from API');
  }
  try {
    final token = response.data['accessToken'];
    if (token == null) {
      return Left('Token not found in response');
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await NotificationService.registerDeviceToken(ApiUrls.registerToken);
      debugPrint("await NotificationS : ${ApiUrls.registerToken}");
    } catch (e) {
      print('SharedPreferences error: $e');
    }
    return Right(response);
  } catch (e) {
    return Left(e);
  }
}
  @override
  Future<Either<dynamic, dynamic>> signup(SignupModel signupReq) async {
    final Either result = await sl<AuthApiService>().signup(signupReq);

    if (result.isLeft()) {
      return Left(result.swap().getOrElse(() => 'Unknown error'));
    }

    final Response? response = result.getOrElse(() => null) as Response?;
    if (response == null) {
      return Left('Empty response from API');
    }
    try {
      final token = response.data['accessToken'];

      if (token == null) {
        return Left('Token not found in response');
      }

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      } catch (e) {
        print('SharedPreferences error: $e');
      }
      return Right(response);
    } catch (e) {
      return Left(e);
    }
  }

  @override
Future<Either<dynamic, dynamic>> sendCode(SendCodeModel sendCode) async {
  try {
    final Either result = await sl<AuthApiService>().sendCode(sendCode);

    if (result.isLeft()) {
      return Left(result.swap().getOrElse(() => 'Unknown error'));
    }

    final Response? response = result.getOrElse(() => null) as Response?;

    return Right(response);
  } catch (e) {
    return Left(e);
  }
}

  @override
  Future<Either<dynamic, dynamic>> verifyCode(VerifyCodeModel sendCode) async {
    try {
    final Either result = await sl<AuthApiService>().verifyCode(sendCode);

    if (result.isLeft()) {
      return Left(result.swap().getOrElse(() => 'Unknown error'));
    }

    final Response? response = result.getOrElse(() => null) as Response?;

    return Right(response);
  } catch (e) {
    return Left(e);
  }
  }
  
}
