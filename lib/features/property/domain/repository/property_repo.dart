import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';

abstract class PropertyRepository {
    Future<Either<Failure, List<Property>>> getAllProperties();
    Future<Either<Failure, Property>> createProperty(CreatePropertyParams property);
    Future<Either<Failure, PropertyDetails>> getPropertyDetails(int id);
}