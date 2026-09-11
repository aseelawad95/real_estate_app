part of 'property_details_cubit.dart';

abstract class PropertyDetailsState extends Equatable {
  const PropertyDetailsState();

  @override
  List<Object?> get props => [];
}

class PropertyDetailsInitial extends PropertyDetailsState {}


class PropertyDetailsLoading extends PropertyDetailsState {}

class PropertyDetailsLoaded extends PropertyDetailsState {
  final PropertyDetails propertyDetails;

  const PropertyDetailsLoaded(this.propertyDetails);

  @override
  List<Object?> get props => [propertyDetails];
}

class PropertyDetailsError extends PropertyDetailsState {
  final String message;

  const PropertyDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}