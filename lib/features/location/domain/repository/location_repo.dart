import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';

abstract class LocationRepository {
    Future<Either<Failure, List<Location>>> getAllLocations();
}