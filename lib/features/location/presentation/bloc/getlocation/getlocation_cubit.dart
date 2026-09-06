import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/location/domain/usecase/location_usecase.dart';

part 'getlocation_state.dart';

class GetlocationCubit extends Cubit<GetlocationState> {
  

   final LocationUseCase locationUseCase;

  GetlocationCubit(this.locationUseCase) : super(GetlocationInitial());

  Future<void> getAllLocations() async {
    if (isClosed) return;
    emit(GetlocationLoading());

    final result = await locationUseCase.call();

    if (isClosed) return;

    result.fold(
      (failure) => emit(GetlocationError(failure.message.toString())),
      (locations) => emit(GetlocationLoaded(locations)),
    );
  }
}
