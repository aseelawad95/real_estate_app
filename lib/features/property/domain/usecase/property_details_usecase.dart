import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/service_locator.dart';

class PropertyDetailsUseCase implements UseCase<Either<Failure, PropertyDetails>, int> {
  @override
  Future<Either<Failure, PropertyDetails>> call({int? param}) async {
    return sl<PropertyRepository>().getPropertyDetails(param!);
  }
}