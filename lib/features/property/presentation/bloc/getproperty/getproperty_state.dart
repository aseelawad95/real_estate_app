part of 'getproperty_cubit.dart';

abstract class GetpropertyState extends Equatable {
  const GetpropertyState();

  @override
  List<Object?> get props => [];
}

class GetpropertyInitial extends GetpropertyState {}


class GetpropertyLoading extends GetpropertyState {}

class GetpropertyLoaded extends GetpropertyState {
  final List<Property> property;

  const GetpropertyLoaded(this.property);

  @override
  List<Object?> get props => [property];
}

class GetpropertyError extends GetpropertyState {
  final String message;

  const GetpropertyError(this.message);

  @override
  List<Object?> get props => [message];
}