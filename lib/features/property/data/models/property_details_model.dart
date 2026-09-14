import 'package:real_estate/features/property/data/models/owner_model.dart';
import 'package:real_estate/features/property/data/models/review_model.dart';
import 'package:real_estate/features/location/data/models/location_model.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';

class PropertyDetailsModel {
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
  final OwnerModel owner;
  final List<String> images;
  final List<ReviewModel> reviews;
  final bool isFavourite;
  final LocationModel? location;

  PropertyDetailsModel({
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

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      area: json['area'] ?? 0,
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      status: json['status'] ?? '',
      listingType: json['listingType'] ?? '',
      approvalStatus: json['approvalStatus'] ?? 0,
      typeName: json['typeName'] ?? '',
      typeIcon: json['typeIcon'] ?? '',
      owner: OwnerModel.fromJson(json),
      images: List<String>.from(json['images'] ?? []),
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((r) => ReviewModel.fromJson(r as Map<String, dynamic>))
          .toList(),
      isFavourite: json['isLiked'] ?? false,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'status': status,
      'listingType': listingType,
      'approvalStatus': approvalStatus,
      'typeName': typeName,
      'typeIcon': typeIcon,
      ...owner.toJson(),
      'images': images,
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'isLiked': isFavourite,
      'location': location?.toJson(),
    };
  }

  PropertyDetails toEntity() {
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
      owner: owner.toEntity(),
      images: images,
      reviews: reviews.map((r) => r.toEntity()).toList(),
      isFavourite: isFavourite,
      location: location?.toEntity(),
    );
  }
}