part of 'getlocation_cubit.dart';

abstract class GetlocationState extends Equatable {
  const GetlocationState();

  @override
  List<Object?> get props => [];
}

class GetlocationInitial extends GetlocationState {}

 
class GetlocationLoading extends GetlocationState {}

class GetlocationLoaded extends GetlocationState {
  final List<Location> locations;

  const GetlocationLoaded(this.locations);


  @override
  List<Object?> get props => [locations];
}

class GetlocationError extends GetlocationState {
  final String message;

  const GetlocationError(this.message);

  @override
  List<Object?> get props => [message];
}