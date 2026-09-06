

import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/profile/data/source/profile_api_service.dart';
import 'package:real_estate/features/profile/domain/entities/user.dart';
import 'package:real_estate/features/profile/domain/repository/profile_repo.dart';






class  UserRepositoryImpl extends  ProfileRepository {
   final  ProfileApiService profileApiService;
    UserRepositoryImpl(this.profileApiService);

   @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    final result = await profileApiService.getUserById(userId);

    return result.fold(
      (failure) => Left(failure),
      (userModel) {
        return Right(userModel.toEntity());
      },
    );
  }


}
