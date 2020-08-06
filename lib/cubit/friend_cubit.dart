import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/friend_repository.dart';

part 'friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit({
    @required this.authCubit,
    @required this.friendRepository,
  }) : super(FriendInitial()) {
    loadInitial();
  }

  final AuthCubit authCubit;
  final FriendRepository friendRepository;

  Future<void> loadInitial() async {
    final friendsF = friendRepository.getFriends();
    final requestsF = friendRepository.getRequests();

    try {
      emit(FriendLoaded(await friendsF, await requestsF));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(FriendLoadingFailure('Something went wrong! Try again later.'));
    }
  }
}
