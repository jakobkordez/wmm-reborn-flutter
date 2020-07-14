part of 'main_cubit.dart';

abstract class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoaded extends MainState {
  final UserModel user;

  MainLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class MainError extends MainState {
  final String error;

  MainError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeError: { error: $error }';
}
