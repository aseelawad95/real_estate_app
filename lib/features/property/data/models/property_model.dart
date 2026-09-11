import 'package:real_estate/features/property/domain/entities/property.dart';

class PropertyModel {
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
  final String ownerName;
  final List<String> images;
  final List<dynamic> reviews;
  final bool isFavourite; // 1️⃣ ضفنا الحقل هون

  PropertyModel({
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
    required this.ownerName,
    required this.images,
    this.reviews = const [],
    this.isFavourite = false,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
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
      ownerName: json['ownerName'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      reviews: json['reviews'] ?? [],
      isFavourite: json['isLiked'] ?? false, 
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
      'ownerName': ownerName,
      'images': images,
      'reviews': reviews,
      'isLiked': isFavourite,
    };
  }

  Property toEntity() {
    return Property(
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
      ownerName: ownerName,
      images: images,
      reviews: reviews,
      isFavourite: isFavourite, 
    );
  }
}