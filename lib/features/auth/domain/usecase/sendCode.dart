import 'package:dartz/dartz.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/auth/data/models/send_sode_model.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/service_locator.dart';

class SendCodeUseCase implements UseCase<Either, SendCodeModel> {

  @override
  Future<Either> call({SendCodeModel ? param}) async {
    return sl<AuthRepository>().sendCode(param!);
  }
  
}