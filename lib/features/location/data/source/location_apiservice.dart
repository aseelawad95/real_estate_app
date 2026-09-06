import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/location/data/models/location_model.dart';
import 'package:real_estate/service_locator.dart';


abstract class LocationApiService {
Future<Either<Failure, List<LocationModel>>> getAllLocations();
}

class LocationApiServiceImp extends LocationApiService{
  @override
  Future<Either<Failure, List<LocationModel>>> getAllLocations() async {
   try {
      final response = await sl<DioClient>().get(ApiUrls.locations);

     final List<LocationModel> locations = (response.data['data'] as List)
    .map((json) => LocationModel.fromJson(json))
    .toList();

      return Right(locations);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  
  }

}