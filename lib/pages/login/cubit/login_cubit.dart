import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required this.userRepository,
    @required this.authCubit,
  }) : super(LoginInitial());

  final UserRepository userRepository;
  final AuthCubit authCubit;

  void loginButtonPressed({
    @required String username,
    @required String password,
  }) async {
    emit(LoginInProgress());

    try {
      if (await userRepository.login(username: username, password: password)) {
        authCubit.login();
        emit(LoginInitial());
      } else
        emit(LoginFailure('Invalid username or password'));
    } on Error {
      emit(LoginFailure('Something went wrong! Try again later.'));
    }
  }
}
