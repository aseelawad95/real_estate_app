import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/propertyType/data/models/property_type_model.dart';
import 'package:real_estate/service_locator.dart';


abstract class PropertyTypeApiService {
Future<Either<Failure, List<PropertyTypeModel>>> getAllPropertyType();
}

class PropertyTypeApiServiceImp extends PropertyTypeApiService{
  @override
  Future<Either<Failure, List<PropertyTypeModel>>> getAllPropertyType() async {
   try {
      final response = await sl<DioClient>().get(ApiUrls.propertyType);

     final List<PropertyTypeModel> propertyTypes = (response.data['data'] as List)
    .map((json) => PropertyTypeModel.fromJson(json))
    .toList();

      return Right(propertyTypes);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  
  }

}