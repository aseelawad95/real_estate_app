part of 'edit_user_cubit.dart';

abstract class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object?> get props => [];
}

class EditUserInitial extends EditUserState {}


class EditUserLoading extends EditUserState {}

class EditUserLoaded extends EditUserState {
  final UserModel user;

  const EditUserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
class EditUserSuccess extends EditUserState {
  final UserModel user;

  const EditUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}


class EditUserError extends EditUserState {
  final String message;

  const EditUserError(this.message);

  @override
  List<Object?> get props => [message];
}
