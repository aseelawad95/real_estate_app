class PropertyFilterParams {
  final bool? search;
  final String? keyword;
  final double? minPrice;
  final double? minRate;
  final double? maxRate;
  final String? country;
  final String? city;
  final double? latitude;
  final double? longitude;
  final double? radiusKm;
  final DateTime? createdFrom;
  final DateTime? createdTo;
  final int page;
  final int limit;

  const PropertyFilterParams({
    this.search,
    this.keyword,
    this.minPrice,
    this.minRate,
    this.maxRate,
    this.country,
    this.city,
    this.latitude,
    this.longitude,
    this.radiusKm,
    this.createdFrom,
    this.createdTo,
    this.page = 1,
    this.limit = 20,
  });

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{'Page': page, 'Limit': limit};

    if (search != null) params['Search'] = search;
    if (keyword != null && keyword!.isNotEmpty) params['Keyword'] = keyword;
    if (minPrice != null) params['MinPrice'] = minPrice;
    if (minRate != null) params['MinRate'] = minRate;
    if (maxRate != null) params['MaxRate'] = maxRate;
    if (country != null && country!.isNotEmpty) params['Country'] = country;
    if (city != null && city!.isNotEmpty) params['City'] = city;
    if (latitude != null) params['Latitude'] = latitude;
    if (longitude != null) params['Longitude'] = longitude;
    if (radiusKm != null) params['RadiusKm'] = radiusKm;
    if (createdFrom != null) {
      params['CreatedFrom'] = createdFrom!.toIso8601String();
    }
    if (createdTo != null) params['CreatedTo'] = createdTo!.toIso8601String();

    return params;
  }

  // بيرجع true إذا في فلتر واحد فعّال (مفيد لعرض "بحث نشط" أو badge)
  bool get hasActiveFilters =>
      (keyword != null && keyword!.isNotEmpty) ||
      minPrice != null ||
      minRate != null ||
      maxRate != null ||
      (country != null && country!.isNotEmpty) ||
      (city != null && city!.isNotEmpty) ||
      radiusKm != null ||
      createdFrom != null ||
      createdTo != null;

  PropertyFilterParams copyWith({
    bool? search,
    String? keyword,
    double? minPrice,
    double? minRate,
    double? maxRate,
    String? country,
    String? city,
    double? latitude,
    double? longitude,
    double? radiusKm,
    DateTime? createdFrom,
    DateTime? createdTo,
    int? page,
    int? limit,
    bool clearCountry = false,
    bool clearCity = false,
  }) {
    return PropertyFilterParams(
      search: search ?? this.search,
      keyword: keyword ?? this.keyword,
      minPrice: minPrice ?? this.minPrice,
      minRate: minRate ?? this.minRate,
      maxRate: maxRate ?? this.maxRate,
      country: clearCountry ? null : (country ?? this.country),
      city: clearCity ? null : (city ?? this.city),
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusKm: radiusKm ?? this.radiusKm,
      createdFrom: createdFrom ?? this.createdFrom,
      createdTo: createdTo ?? this.createdTo,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}