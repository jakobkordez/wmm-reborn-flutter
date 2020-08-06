part of 'user_search_cubit.dart';

abstract class UserSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSearchInitial extends UserSearchState {}

class UserSearchFailure extends UserSearchState {
  final String error;

  UserSearchFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UserSearchEmpty extends UserSearchState {}

class UserSearchFound extends UserSearchState {
  final List<UserModel> users;

  UserSearchFound(this.users);

  @override
  List<Object> get props => [users];
}

class UserSearchLoading extends UserSearchState {}
