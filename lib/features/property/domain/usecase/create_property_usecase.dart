import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/service_locator.dart';


class CreatePropertyUseCase implements UseCase<Either<Failure, Property>, CreatePropertyParams> {
  @override
  Future<Either<Failure, Property>> call({CreatePropertyParams? param}) async {
    return sl<PropertyRepository>().createProperty(param!);
  }
}