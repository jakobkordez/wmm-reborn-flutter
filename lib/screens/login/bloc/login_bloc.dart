import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wmm_reborn_flutter/services/user_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;

  LoginBloc({@required this.userService});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        if (await userService.authenticate(username: event.username, password: event.password))
          yield LoginInitial();
        else
          yield LoginFailure(error: 'Something went wrong! Try again later.');
      } on Error {
        yield LoginFailure(error: 'Something went wrong! Try again later.');
    }
    }
  }
}
