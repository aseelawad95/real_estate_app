import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';
import 'package:real_estate/features/propertyType/domain/usecase/property_type_usecase.dart';

part 'property_type_state.dart';

class PropertyTypeCubit extends Cubit<PropertyTypeState> {
  final PropertyTypeUseCase propertyTypeUseCase;

  PropertyTypeCubit(this.propertyTypeUseCase) : super(PropertyTypeInitial());

  Future<void> getAllPropertyTypes() async {
    if (isClosed) return;
    emit(PropertyTypeLoading());

    final result = await propertyTypeUseCase.call();

    if (isClosed) return;

    result.fold(
      (failure) => emit(PropertyTypeError(failure.message.toString())),
      (propertyType) => emit(PropertyTypeLoaded(propertyType)),
    );
  }
}