import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:real_estate/core/usecase/usecase.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitialState());

   void excute({dynamic params, required UseCase usecase}) async {

    emit(ButtonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
     Either result = await usecase.call(param: params);

     result.fold(
      (error) {
        emit(
          ButtonFailureState(errorMessage: error)
        );
      },
      (data) {
        emit(ButtonSuccessState());
      }

     );
    } catch(e){
      emit(
        ButtonFailureState(errorMessage: e.toString())
      );
    }
  }
}
