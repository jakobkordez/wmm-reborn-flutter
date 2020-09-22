part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Username username;
  final Password password;
  final FormzStatus status;

  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({
    Username username,
    Password password,
    FormzStatus status,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [username, password, status];
}
