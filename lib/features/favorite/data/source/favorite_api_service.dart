import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/favorite/data/models/favorite_model.dart';
import 'package:real_estate/service_locator.dart';


abstract class FavoriteApiService {
  Future<Either<Failure, List<FavoriteModel>>> getFavoritesByUserId(String userId);
}

class FavoriteApiServiceImp extends FavoriteApiService{
 @override
  Future<Either<Failure, List<FavoriteModel>>> getFavoritesByUserId(String userId) async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.favoritesByUserId(userId));

      final List<FavoriteModel> favorites = (response.data['data'] as List)
          .map((json) => FavoriteModel.fromJson(json))
          .toList();

      return Right(favorites);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}