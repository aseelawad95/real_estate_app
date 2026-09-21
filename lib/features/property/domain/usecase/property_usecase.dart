import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/features/search/domain/entities/property_filter.dart';
import 'package:real_estate/service_locator.dart';


class PropertyUseCase
    implements UseCase<Either<Failure, List<Property>>, PropertyFilterParams?> {
  @override
  Future<Either<Failure, List<Property>>> call({
    PropertyFilterParams? param,
  }) async {
    return sl<PropertyRepository>().getAllProperties(filter: param);
  }
}