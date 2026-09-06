part of 'get_userby_id_cubit.dart';

abstract class GetUserbyIdState extends Equatable {
  const GetUserbyIdState();

  @override
  List<Object?> get props => [];
}

class GetUserbyIdInitial extends GetUserbyIdState {}

class GetUserByIdLoading extends GetUserbyIdState {}

class GetUserByIdLoaded extends GetUserbyIdState {
  final User user;

  const GetUserByIdLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class GetUserByIdError extends GetUserbyIdState {
  final String message;

  const GetUserByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
