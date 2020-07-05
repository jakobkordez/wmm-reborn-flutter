import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_reborn_flutter/bloc/auth_bloc.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.userRepository, @required this.authBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        if (await userRepository.authenticate(
            username: event.username, password: event.password)) {
          authBloc.add(AuthLoggedIn());
          yield LoginInitial();
        } else
          yield LoginFailure(error: 'Invalid username or password');
      } on Error {
        yield LoginFailure(error: 'Something went wrong! Try again later.');
      }
    }
  }
}
