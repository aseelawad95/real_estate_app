import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/favorite/domain/entities/favorite_entity.dart';
import 'package:real_estate/features/favorite/domain/usecase/favorite_usecase.dart';

part 'get_favorite_user_state.dart';

class GetFavoriteUserCubit extends Cubit<GetFavoriteUserState> {
 
  
  final GetFavoritesByUserIdUseCase getFavoritesByUserIdUseCase;

    GetFavoriteUserCubit(this.getFavoritesByUserIdUseCase) : super(GetFavoriteUserInitial());

  Future<void> getFavoritesByUserId(String userId) async {
    emit(GetFavoriteUserLoading());

     final result = await getFavoritesByUserIdUseCase.call(param: userId);

    result.fold(
      (failure) => emit(GetFavoriteUserError(failure.message.toString())),
      (propertyType) => emit(GetFavoriteUserLoaded(propertyType)),
    );
  }
}
