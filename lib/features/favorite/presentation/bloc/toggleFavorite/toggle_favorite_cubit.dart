import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/favorite/domain/entities/toggle_entity.dart';
import 'package:real_estate/features/favorite/domain/usecase/toggle_favorite_usecase.dart';
import 'package:real_estate/service_locator.dart';

part 'toggle_favorite_state.dart';

class ToggleFavoriteCubit extends Cubit<ToggleFavoriteState> {
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  final Map<int, bool> _favoriteOverrides = {};

  ToggleFavoriteCubit(this.toggleFavoriteUseCase) : super(ToggleFavoriteInitial());

  bool? isFavorited(int propertyId) => _favoriteOverrides[propertyId];

  Future<void> toggleFavorite(int propertyId, String userId) async {
    emit(ToggleFavoriteLoading(propertyId));

    final result = await sl<ToggleFavoriteUseCase>().call(
      param: ToggleFavoriteParams(id: propertyId, userId: userId),
    );

    result.fold(
      (failure) => emit(
        ToggleFavoriteError(propertyId: propertyId, message: failure.message),
      ),
      (isFavorited) {
        _favoriteOverrides[propertyId] = isFavorited; 
        emit(ToggleFavoriteLoaded(propertyId: propertyId, isFavorited: isFavorited));
      },
    );
  }
}