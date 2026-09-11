import 'package:equatable/equatable.dart';

class Property extends Equatable {
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
  final bool isFavourite;

  const Property({
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

  Property copyWith({bool? isFavourite}) {
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
      isFavourite: isFavourite ?? this.isFavourite,
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
        ownerName,
        images,
        reviews,
        isFavourite,
      ];
}