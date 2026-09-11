import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/owner.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';

class PropertyDetails extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final double price;
  final int area;
  final int bedrooms;
  final int bathrooms;
  final String status;
  final String listingType;
  final int approvalStatus;
  final String typeName;
  final String typeIcon;
  final Owner owner;
  final List<String> images;
  final List<dynamic> reviews;
  final bool isFavourite;
  final Location? location;

  const PropertyDetails({
    required this.id,
    this.title,
    this.description,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.status,
    required this.listingType,
    required this.approvalStatus,
    required this.typeName,
    required this.typeIcon,
    required this.owner,
    required this.images,
    this.reviews = const [],
    this.isFavourite = false,
    this.location,
  });

  PropertyDetails copyWith({bool? isFavourite}) {
    return PropertyDetails(
      id: id,
      title: title,
      description: description,
      price: price,
      area: area,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      status: status,
      listingType: listingType,
      approvalStatus: approvalStatus,
      typeName: typeName,
      typeIcon: typeIcon,
      owner: owner,
      images: images,
      reviews: reviews,
      isFavourite: isFavourite ?? this.isFavourite,
      location: location,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        area,
        bedrooms,
        bathrooms,
        status,
        listingType,
        approvalStatus,
        typeName,
        typeIcon,
        owner,
        images,
        reviews,
        isFavourite,
        location,
      ];
}