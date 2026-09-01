import 'package:dartz/dartz.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/auth/data/models/signup_model.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/service_locator.dart';

class SignUpUseCase implements UseCase<Either, SignupModel> {

  @override
  Future<Either> call({SignupModel ? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
  
}