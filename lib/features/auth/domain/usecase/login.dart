import 'package:dartz/dartz.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/auth/data/models/login_model.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/service_locator.dart';

class LoginUseCase implements UseCase<Either, LoginModel> {

  @override
  Future<Either> call({LoginModel ? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
  
}