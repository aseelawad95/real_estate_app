part of 'get_favorite_user_cubit.dart';

abstract class GetFavoriteUserState extends Equatable {
  const GetFavoriteUserState();

  @override
  List<Object?> get props => [];
}

class GetFavoriteUserInitial extends GetFavoriteUserState {}

class GetFavoriteUserLoading extends GetFavoriteUserState {}

class GetFavoriteUserLoaded extends GetFavoriteUserState {
  final List<FavoriteEntity> favorites;

  const GetFavoriteUserLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class GetFavoriteUserError extends GetFavoriteUserState {
  final String message;

  const GetFavoriteUserError(this.message);

  @override
  List<Object?> get props => [message];
}