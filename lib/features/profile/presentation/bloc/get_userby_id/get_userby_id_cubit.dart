import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/profile/domain/entities/user.dart';
import 'package:real_estate/features/profile/domain/usecase/profile_usecase.dart';

part 'get_userby_id_state.dart';

class GetUserbyIdCubit extends Cubit<GetUserbyIdState> {

  final GetUserByIdUseCase getUserByIdUseCase;

    GetUserbyIdCubit(this.getUserByIdUseCase) : super(GetUserbyIdInitial());

  Future<void> getUserById(String userId) async {
    emit(GetUserByIdLoading());

     final result = await getUserByIdUseCase.call(param: userId);

    result.fold(
      (failure) => emit(GetUserByIdError(failure.message.toString())),
      (user) => emit(GetUserByIdLoaded(user)),
    );
  }

  void updateLocalUser(User user) {
    emit(GetUserByIdLoaded(user));
  }
}
