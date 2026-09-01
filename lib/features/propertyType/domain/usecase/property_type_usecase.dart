import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';
import 'package:real_estate/features/propertyType/domain/repository/property_type_repo.dart';
import 'package:real_estate/service_locator.dart';


class PropertyTypeUseCase implements UseCase<Either<Failure, List<PropertyType>>, void> {
  @override
  Future<Either<Failure, List<PropertyType>>> call({void param}) async {
    return sl<PropertyTypeRepository>().getAllPropertyType();
  }
}