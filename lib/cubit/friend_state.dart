part of 'friend_cubit.dart';

abstract class FriendState extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendInitial extends FriendState {}

class FriendLoaded extends FriendState {
  FriendLoaded(this.friends);

  final List<UserModel> friends;

  @override
  List<Object> get props => [friends];
}

class FriendLoadingFailure extends FriendState {
  final String error;

  FriendLoadingFailure(this.error);

  @override
  List<Object> get props => [error];
}
