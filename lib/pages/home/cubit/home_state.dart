part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final UserModel user;

  HomeLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeError: { error: $error }';
}
