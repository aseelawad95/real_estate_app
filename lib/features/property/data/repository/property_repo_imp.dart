import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/property/data/source/property_api_service.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/features/search/domain/entities/property_filter.dart';



class  PropertyRepositoryImpl extends  PropertyRepository {
   final  PropertyApiService propertyApiService;
    PropertyRepositoryImpl(this.propertyApiService);

  @override
  Future<Either<Failure, List<Property>>> getAllProperties({
    PropertyFilterParams? filter,
  }) async {
    final result = await propertyApiService.getAllProperties(filter: filter);
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((m) => m.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Property>> createProperty(CreatePropertyParams property) async {
    final result = await propertyApiService.createProperty(property);
  
   return result.fold(
    (failure) => Left(failure),
    (propertyModel) {
      final entity = propertyModel.toEntity();
      return Right(entity);
    },
  );
  }

 @override
Future<Either<Failure, PropertyDetails>> getPropertyDetails(int id) async {
  final result = await propertyApiService.getPropertyDetails(id);

  return result.fold(
    (failure) => Left(failure),
    (propertyDetailsModel) => Right(propertyDetailsModel.toEntity()),
  );
}


}
