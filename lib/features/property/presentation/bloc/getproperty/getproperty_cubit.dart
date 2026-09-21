import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/domain/usecase/property_usecase.dart';
import 'package:real_estate/features/search/domain/entities/property_filter.dart';

part 'getproperty_state.dart';

class GetpropertyCubit extends Cubit<GetpropertyState> {
 
final PropertyUseCase propertyUseCase;

    GetpropertyCubit(this.propertyUseCase) : super(GetpropertyInitial());

   PropertyFilterParams _currentFilter = const PropertyFilterParams();
  PropertyFilterParams get currentFilter => _currentFilter;

  Future<void> getAllProperties() async {
    emit(GetpropertyLoading());
    final result = await propertyUseCase.call();
    result.fold(
      (failure) => emit(GetpropertyError(failure.message.toString())),
      (property){
        print('Fetched ${property.length} properties: ${property.map((p) => p.id).toList()}');
        emit(GetpropertyLoaded(property));
      } 
    );
  }

  Future<void> applyFilters(PropertyFilterParams filter) async {
    _currentFilter = filter;
    emit(GetpropertyLoading());
    final result = await propertyUseCase.call(param: filter);
    result.fold(
      (failure) => emit(GetpropertyError(failure.message.toString())),
      (property) => emit(GetpropertyLoaded(property)),
    );
  }

  Future<void> searchByKeyword(String keyword) async {
    final trimmed = keyword.trim();
    await applyFilters(
      _currentFilter.copyWith(
        search: true,
        keyword: trimmed.isEmpty ? null : trimmed,
      ),
    );
  }

  Future<void> resetFilters() async {
    _currentFilter = const PropertyFilterParams();
    await getAllProperties();
  }
  
}
