import 'package:dartz/dartz.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/auth/data/models/verify_code_model.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/service_locator.dart';

class VerifyCodeUseCase implements UseCase<Either, VerifyCodeModel> {

  @override
  Future<Either> call({VerifyCodeModel ? param}) async {
    return sl<AuthRepository>().verifyCode(param!);
  }
  
}