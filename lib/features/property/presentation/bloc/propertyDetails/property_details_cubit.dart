import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/domain/usecase/property_details_usecase.dart';

part 'property_details_state.dart';

class PropertyDetailsCubit extends Cubit<PropertyDetailsState> {
  final PropertyDetailsUseCase propertyDetailsUseCase;
  PropertyDetailsCubit(this.propertyDetailsUseCase) : super(PropertyDetailsInitial());

  Future<void> propertyDetails(int id) async {
    emit(PropertyDetailsLoading());

     final result = await propertyDetailsUseCase.call(param: id);

    result.fold(
      (failure) => emit(PropertyDetailsError(failure.message.toString())),
      (propertyType) => emit(PropertyDetailsLoaded(propertyType)),
    );
  }
}
