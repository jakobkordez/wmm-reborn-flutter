import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/pages/login/models/models.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({@required this.userRepository}) : super(const RegisterState());

  final UserRepository userRepository;

  Future<void> submit() async {
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

  Future<void> setName(String value) async {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.username,
        state.password,
        state.rePassword,
        state.email,
      ]),
    ));
  }

  Future<void> setUsername(String value) async {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.name,
        state.password,
        state.rePassword,
        state.email,
      ]),
    ));
  }

  Future<void> setPassword(String value) async {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.name,
        state.username,
        state.rePassword,
        state.email,
      ]),
    ));
  }

  Future<void> setRePassword(String value) async {
    final rePassword = Password.dirty(value);
    emit(state.copyWith(
      rePassword: rePassword,
      status: Formz.validate([
        rePassword,
        state.name,
        state.username,
        state.password,
        state.email,
      ]),
    ));
  }

  Future<void> setEmail(String value) async {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.name,
        state.username,
        state.password,
        state.rePassword,
      ]),
    ));
  }
}
