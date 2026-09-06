import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/profile/domain/entities/user.dart';


abstract class ProfileRepository {
     Future<Either<Failure, User>> getUserById(String userId);

}
