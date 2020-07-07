import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    @required this.userRepository,
  }) : super(AuthInitial()) {
    _checkLogin();
  }

  final UserRepository userRepository;

  void _checkLogin() async {
    emit(AuthInProgress());

    try {
      if (!await userRepository.hasToken())
        emit(AuthFailure());
      else if (await userRepository.getAccessToken(getNew: true) != null) {
        emit(AuthSuccess());
      }
    } on Error {
      emit(AuthFailure());
    }
  }

  void logout() {
    userRepository.logout();
    emit(AuthFailure());
  }

  void login() => emit(AuthSuccess());
}
