import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/usecase/create_property_usecase.dart';

part 'createproperty_state.dart';

class CreatepropertyCubit extends Cubit<CreatepropertyState> {
 
final CreatePropertyUseCase createPropertyUseCase;

    CreatepropertyCubit(this.createPropertyUseCase) : super(CreatepropertyInitial());

  // Future<void> getAllProperties() async {
  //   emit(CreatepropertyLoading());

  //   final result = await createPropertyUseCase.call();

  //   result.fold(
  //     (failure) => emit(CreatepropertyError(failure.message.toString())),
  //     (property) => emit(CreatepropertyLoaded(property)),
  //   );
  // }

  Future<void> createProperty(CreatePropertyParams params) async {
  emit(CreatepropertyLoading());

  final result = await createPropertyUseCase.call(param: params);

  result.fold(
    (failure) => emit(CreatepropertyError(failure.message.toString())),
    (property) => emit(CreatepropertyLoaded(property)),
  );
}
  
}
