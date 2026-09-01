import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/usecase/property_usecase.dart';

part 'getproperty_state.dart';

class GetpropertyCubit extends Cubit<GetpropertyState> {
 
final PropertyUseCase propertyUseCase;

    GetpropertyCubit(this.propertyUseCase) : super(GetpropertyInitial());

  Future<void> getAllProperties() async {
    emit(GetpropertyLoading());

    final result = await propertyUseCase.call();

    result.fold(
      (failure) => emit(GetpropertyError(failure.message.toString())),
      (property) => emit(GetpropertyLoaded(property)),
    );
  }
  
}
