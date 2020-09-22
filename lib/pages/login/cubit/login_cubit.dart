import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/pages/login/models/models.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required this.userRepository,
    @required this.authCubit,
  }) : super(const LoginState());

  final UserRepository userRepository;
  final AuthCubit authCubit;

  Future<void> submit() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await userRepository.login(
        username: state.username.value,
        password: state.password.value,
      );
      authCubit.login();

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> setUsername(String value) async {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  Future<void> setPassword(String value) async {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }
}
