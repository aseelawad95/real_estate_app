import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/profile/data/models/user_model.dart';
import 'package:real_estate/features/profile/domain/repository/profile_repo.dart';
import 'package:real_estate/service_locator.dart';



class EditUserUseCase implements UseCase<Either<Failure, UserModel>, Map<String, dynamic>> {
  @override
  Future<Either<Failure, UserModel>> call({Map<String, dynamic>? param}) async {
    final userId = param?['userId'] as String;
    final user = param?['user'] as UserModel;
    return sl<ProfileRepository>().editUser(userId, user);
  }
}