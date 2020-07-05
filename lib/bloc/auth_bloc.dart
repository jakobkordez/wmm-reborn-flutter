import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc(this.userRepository);

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield AuthInProgress();

      try {
        if (!await userRepository.hasToken())
          yield AuthFailure();
        else if (await userRepository.getAccessToken(getNew: true) != null) {
          yield AuthSuccess();
        }
      } on Error {
        yield AuthFailure();
      }
    }

    if (event is AuthLoggedIn) {
      yield AuthSuccess();
    }

    if (event is AuthLoggedOut) {
      userRepository.logout();
      yield AuthFailure();
    }
  }
}
