import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/models/inputs/email.dart';
import 'package:wmm_flutter/models/inputs/name.dart';
import 'package:wmm_flutter/models/inputs/password.dart';
import 'package:wmm_flutter/models/inputs/username.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({@required this.userRepository}) : super(const RegisterState());

  final UserRepository userRepository;

  void onNameChanged(String value) {
    final name = NameInput.dirty(value);
    emit(state.copyWith(name: name));
  }

  void onUsernameChanged(String value) {
    final username = UsernameInput.dirty(value);
    emit(state.copyWith(username: username));
  }

  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(state.copyWith(password: password));
  }

  void onRepeatPasswordChanged(String value) {
    final rePassword = PasswordInput.dirty(value);
    emit(state.copyWith(rePassword: rePassword));
  }

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(email: email));
  }

  Future<void> register() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await userRepository.register(
        name: state.name.value,
        username: state.username.value,
        password: state.password.value,
        email: state.email.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
