import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/location/data/source/location_apiservice.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/location/domain/repository/location_repo.dart';




class  LocationRepositoryImpl extends  LocationRepository {
   final  LocationApiService locationApiService;
    LocationRepositoryImpl(this.locationApiService);

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
     final result = await locationApiService.getAllLocations();
  
   return result.fold(
      (failure) => Left(failure),
      (locationModels) {
        final location = locationModels.map((model) => model.toEntity()).toList();
        return Right(location); 
      },
    );
  }


}
