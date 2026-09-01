import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/favorite/domain/entities/favorite_entity.dart';
import 'package:real_estate/features/favorite/domain/repository/favorite_repo.dart';
import 'package:real_estate/service_locator.dart';

class GetFavoritesByUserIdUseCase implements UseCase<Either<Failure, List<FavoriteEntity>>, String> {
  @override
  Future<Either<Failure, List<FavoriteEntity>>> call({String? param}) async {
    return sl<FavoriteRepository>().getFavoritesByUserId(param!);
  }
}