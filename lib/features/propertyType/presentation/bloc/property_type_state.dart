part of 'property_type_cubit.dart';

abstract class PropertyTypeState extends Equatable {
  const PropertyTypeState();

  @override
  List<Object?> get props => [];
}

class PropertyTypeInitial extends PropertyTypeState {}

class PropertyTypeLoading extends PropertyTypeState {}

class PropertyTypeLoaded extends PropertyTypeState {
  final List<PropertyType> propertyType;
  final int? selectedTypeId;

  const PropertyTypeLoaded(this.propertyType,{this.selectedTypeId});

  @override
  List<Object?> get props => [propertyType];
}

class PropertyTypeError extends PropertyTypeState {
  final String message;

  const PropertyTypeError(this.message);

  @override
  List<Object?> get props => [message];
}