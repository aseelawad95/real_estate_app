import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/property/data/source/property_api_service.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';



class  PropertyRepositoryImpl extends  PropertyRepository {
   final  PropertyApiService propertyApiService;
    PropertyRepositoryImpl(this.propertyApiService);

  @override
  Future<Either<Failure, List<Property>>> getAllProperties() async {
     final result = await propertyApiService.getAllProperties();
  
   return result.fold(
      (failure) => Left(failure),
      (propertyModels) {
        final properties = propertyModels.map((model) => model.toEntity()).toList();
        return Right(properties); 
      },
    );
  }


}
