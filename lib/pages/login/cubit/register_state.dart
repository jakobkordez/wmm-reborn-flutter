part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final Name name;
  final Username username;
  final Password password, rePassword;
  final Email email;
  final FormzStatus status;

  const RegisterState({
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.rePassword = const Password.pure(),
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
  });

  RegisterState copyWith({
    Name name,
    Username username,
    Password password,
    Password rePassword,
    Email email,
    FormzStatus status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [name, username, password, rePassword, email, status];
}
