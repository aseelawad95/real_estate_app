import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/profile/domain/entities/user.dart';
import 'package:real_estate/features/profile/domain/repository/profile_repo.dart';
import 'package:real_estate/service_locator.dart';



class GetUserByIdUseCase implements UseCase<Either<Failure, User>, String> {
  @override
  Future<Either<Failure,User>> call({String? param}) async {
    return sl<ProfileRepository>().getUserById(param!);
  }
}