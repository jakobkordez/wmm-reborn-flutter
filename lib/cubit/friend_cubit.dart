import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/friend_repository.dart';

part 'friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit({
    @required this.authCubit,
    @required this.friendRepository,
  }) : super(FriendInitial());

  final AuthCubit authCubit;
  final FriendRepository friendRepository;
}
