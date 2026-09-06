import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/property/data/models/property_model.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/service_locator.dart';


abstract class PropertyApiService {
Future<Either<Failure, List<PropertyModel>>> getAllProperties();
Future<Either<Failure, PropertyModel>> createProperty(CreatePropertyParams property);
}

class PropertyApiServiceImp extends PropertyApiService{
  @override
  Future<Either<Failure, List<PropertyModel>>> getAllProperties() async {
   try {
      final response = await sl<DioClient>().get(ApiUrls.property);

     final List<PropertyModel> properties = (response.data['data'] as List)
    .map((json) => PropertyModel.fromJson(json))
    .toList();

      return Right(properties);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  
  }

  @override
  Future<Either<Failure, PropertyModel>> createProperty(CreatePropertyParams property) async {
   try {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('TypeId', property.propertyTypeId.toString()),
      MapEntry('OwnerId', property.ownerId),
      MapEntry('Price', property.price.toString()),
      MapEntry('Area', property.area.toString()),
      MapEntry('Bedrooms', property.bedrooms.toString()),
      MapEntry('Bathrooms', property.bathrooms.toString()),
      MapEntry('LocationId', property.locationId.toString()),
      MapEntry('Status', 'Available'),           
      MapEntry('ListingType', property.listingType),
      MapEntry('ApprovalStatus', 'Pending'),     
      MapEntry('OwnerPhone', property.ownerPhone.toString()),
    ]);

    for (int i = 0; i < property.translations.length; i++) {
      final t = property.translations[i];
      formData.fields.add(MapEntry('Translations[$i].Title', t.title));
      formData.fields.add(MapEntry('Translations[$i].Language', t.language));  
      if (t.description != null && t.description!.isNotEmpty) {
        formData.fields.add(MapEntry('Translations[$i].Description', t.description!));
      }
    }

    if (property.images != null && property.images!.isNotEmpty) {
      for (final path in property.images!) {
        formData.files.add(MapEntry(
          'Images',
          await MultipartFile.fromFile(path, filename: path.split('/').last),
        ));
      }
    }

    debugPrint("FormData fields: ${formData.fields}");

    final response = await sl<DioClient>().post(ApiUrls.property, data: formData);
    final PropertyModel properties = PropertyModel.fromJson(response.data['data']);
    return Right(properties);
  } on DioException catch (e) {
    debugPrint("STATUS: ${e.response?.statusCode}");
    debugPrint("HEADERS: ${e.response?.headers}");
    debugPrint("DATA TYPE: ${e.response?.data.runtimeType}");
    debugPrint("DATA RAW: ${e.response?.data}");
    debugPrint("REQUEST HEADERS: ${e.requestOptions.headers}");
    debugPrint("REQUEST CONTENT-TYPE: ${e.requestOptions.contentType}");

    final message = e.response?.data is Map
        ? (e.response?.data['message'] ?? 'Unknown error')
        : (e.response?.data?.toString().isNotEmpty == true
            ? e.response!.data.toString()
            : 'Unknown error');
    return Left(ServerFailure(message));
  } catch (e, stack) {
    debugPrint("GENERIC ERROR: $e");
    debugPrint("STACK TRACE: $stack");
    return Left(ServerFailure(e.toString()));
  }
}
}