import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String comment;
  final int rate;
  final String userName;
  final DateTime createdAt;

  const Review({
    required this.comment,
    required this.rate,
    required this.userName,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [comment, rate, userName, createdAt];
}