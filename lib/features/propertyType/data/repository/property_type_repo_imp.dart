import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/propertyType/data/source/property_type_apiservice.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';
import 'package:real_estate/features/propertyType/domain/repository/property_type_repo.dart';



class  PropertyTypeRepositoryImpl extends  PropertyTypeRepository {
   final  PropertyTypeApiService propertyTypeApiService;
    PropertyTypeRepositoryImpl(this.propertyTypeApiService);

  @override
  Future<Either<Failure, List<PropertyType>>> getAllPropertyType() async {
     final result = await propertyTypeApiService.getAllPropertyType();
  
   return result.fold(
      (failure) => Left(failure),
      (propertTypeModels) {
        final propertyType = propertTypeModels.map((model) => model.toEntity()).toList();
        return Right(propertyType); 
      },
    );
  }


}
