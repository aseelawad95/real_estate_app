import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/property/data/models/property_model.dart';
import 'package:real_estate/service_locator.dart';


abstract class PropertyApiService {
Future<Either<Failure, List<PropertyModel>>> getAllProperties();
}

class PropertyApiServiceImp extends PropertyApiService{
  @override
  Future<Either<Failure, List<PropertyModel>>> getAllProperties() async {
   try {
      final response = await sl<DioClient>().get(ApiUrls.property);

     final List<PropertyModel> properties = (response.data['data'] as List)
    .map((json) => PropertyModel.fromJson(json))
    .toList();

      return Right(properties);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  
  }

}