import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/favorite/domain/entities/toggle_entity.dart';
import 'package:real_estate/features/favorite/domain/repository/favorite_repo.dart';
import 'package:real_estate/service_locator.dart';

class ToggleFavoriteUseCase implements UseCase<Either<Failure, bool>, ToggleFavoriteParams> {
  @override
  Future<Either<Failure, bool>> call({ToggleFavoriteParams? param}) async {
    return sl<FavoriteRepository>().toggleFavorite(param!.id, param.userId);
  }
}