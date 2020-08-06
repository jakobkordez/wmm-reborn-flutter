import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    @required this.userRepository,
    @required this.authCubit,
  }) : super(UserInitial()) {
    loadInitial();
  }

  final UserRepository userRepository;
  final AuthCubit authCubit;

  Future<void> loadInitial() async {
    try {
      UserModel user = await userRepository.getUser(getNew: true);
      emit(UserLoaded(user));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(UserLoadingFailure('Something went wrong! Try again later.'));
    }
  }
}
