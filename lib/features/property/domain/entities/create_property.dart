class TranslationParam {
  final String language;
  final String title;
  final String? description;

  TranslationParam({
    required this.language,
    required this.title,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'language': language,
    'title': title,
    'description': description,
  };
}

class CreatePropertyParams {
  final double price;
  final int area;
  final int bedrooms;
  final int bathrooms;
  final int locationId;
  final int propertyTypeId;
  final String listingType;
  final String ownerId;
  final int ownerPhone;
  final List<String>? images;
  final List<TranslationParam> translations;

  CreatePropertyParams({
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.locationId,
    required this.propertyTypeId,
    required this.listingType,
    required this.ownerId,
    required this.ownerPhone,
    this.images,
    required this.translations,
  });

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'locationId': locationId,
      'propertyTypeId': propertyTypeId,
      'listingType': listingType,
      'ownerId': ownerId,
      'ownerPhone': ownerPhone,
      'images': images,
      'translations': translations.map((t) => t.toJson()).toList(),
    };
  }
}