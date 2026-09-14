import 'package:real_estate/features/property/domain/entities/review.dart';

class ReviewModel {
  final String comment;
  final int rate;
  final String userName;
  final DateTime createdAt;

  ReviewModel({
    required this.comment,
    required this.rate,
    required this.userName,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment'] ?? '',
      rate: json['rate'] ?? 0,
      userName: json['userName'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'rate': rate,
      'userName': userName,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Review toEntity() {
    return Review(
      comment: comment,
      rate: rate,
      userName: userName,
      createdAt: createdAt,
    );
  }
}