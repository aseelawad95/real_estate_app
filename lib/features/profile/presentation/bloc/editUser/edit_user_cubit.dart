import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/profile/data/models/user_model.dart';
import 'package:real_estate/features/profile/domain/usecase/edit_user_usecase.dart';

part 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  
   final EditUserUseCase editUserUseCase;

    EditUserCubit(this.editUserUseCase) : super(EditUserInitial());

  Future<void> editUser(String userId, UserModel user) async {
    emit(EditUserLoading());

     final result = await editUserUseCase.call(param: {'userId': userId, 'user': user});

    result.fold(
      (failure) => emit(EditUserError(failure.message.toString())),
      (user) {
        emit(EditUserSuccess(user)); 
      },
    );
  }
}
