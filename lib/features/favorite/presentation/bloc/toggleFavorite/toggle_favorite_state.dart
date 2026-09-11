part of 'toggle_favorite_cubit.dart';

abstract class ToggleFavoriteState extends Equatable {
  const ToggleFavoriteState();

  @override
  List<Object?> get props => [];
}

class ToggleFavoriteInitial extends ToggleFavoriteState {}

class ToggleFavoriteLoading extends ToggleFavoriteState {
  final int propertyId;

  const ToggleFavoriteLoading(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class ToggleFavoriteLoaded extends ToggleFavoriteState {
  final int propertyId;
  final bool isFavorited;

  const ToggleFavoriteLoaded({
    required this.propertyId,
    required this.isFavorited,
  });

  @override
  List<Object?> get props => [propertyId, isFavorited];
}

class ToggleFavoriteError extends ToggleFavoriteState {
  final int propertyId;
  final String message;

  const ToggleFavoriteError({
    required this.propertyId,
    required this.message,
  });

  @override
  List<Object?> get props => [propertyId, message];
}