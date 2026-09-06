import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/location/domain/repository/location_repo.dart';
import 'package:real_estate/service_locator.dart';



class LocationUseCase implements UseCase<Either<Failure, List<Location>>, void> {
  @override
  Future<Either<Failure, List<Location>>> call({void param}) async {
    return sl<LocationRepository>().getAllLocations();
  }
}