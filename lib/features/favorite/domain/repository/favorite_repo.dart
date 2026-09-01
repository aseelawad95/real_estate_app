import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/favorite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {
     Future<Either<Failure, List<FavoriteEntity>>> getFavoritesByUserId(String userId);

}
