import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';

abstract class PropertyTypeRepository {
    Future<Either<Failure, List<PropertyType>>> getAllPropertyType();
}