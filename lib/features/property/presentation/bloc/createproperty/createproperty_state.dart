part of 'createproperty_cubit.dart';

abstract class CreatepropertyState extends Equatable {
  const CreatepropertyState();

  @override
  List<Object?> get props => [];
}

class CreatepropertyInitial extends CreatepropertyState {}

class CreatepropertyLoading extends CreatepropertyState {}

class CreatepropertyLoaded extends CreatepropertyState {
  final Property property;   

  const CreatepropertyLoaded(this.property);

  @override
  List<Object?> get props => [property];
}

class CreatepropertyError extends CreatepropertyState {
  final String message;

  const CreatepropertyError(this.message);

  @override
  List<Object?> get props => [message];
}