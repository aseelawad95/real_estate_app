
import 'package:dartz/dartz.dart';
import 'package:real_estate/features/auth/data/models/login_model.dart';
import 'package:real_estate/features/auth/data/models/send_sode_model.dart';
import 'package:real_estate/features/auth/data/models/signup_model.dart';
import 'package:real_estate/features/auth/data/models/verify_code_model.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupModel signupReq);
  Future<Either> signin(LoginModel loginReq);
  Future<Either> sendCode(SendCodeModel sendCode);
  Future<Either> verifyCode(VerifyCodeModel sendCode);

  // Future<bool> isLoggedIn();
  // Future<Either> getUser();
  // Future<Either> logout();
}