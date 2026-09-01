

import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/favorite/data/source/favorite_api_service.dart';
import 'package:real_estate/features/favorite/domain/entities/favorite_entity.dart';
import 'package:real_estate/features/favorite/domain/repository/favorite_repo.dart';




class  FavoriteRepositoryImpl extends  FavoriteRepository {
   final  FavoriteApiService favoriteApiService;
    FavoriteRepositoryImpl(this.favoriteApiService);

   @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavoritesByUserId(String userId) async {
    final result = await favoriteApiService.getFavoritesByUserId(userId);

    return result.fold(
      (failure) => Left(failure),
      (favoriteModel) {
        final favorites = favoriteModel.map((model) => model.toEntity()).toList();
        return Right(favorites);
      },
    );
  }


}
