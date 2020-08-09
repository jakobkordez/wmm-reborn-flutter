part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final NameInput name;
  final UsernameInput username;
  final PasswordInput password, rePassword;
  final EmailInput email;
  final FormzStatus status;

  const RegisterState({
    this.name = const NameInput.pure(),
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.rePassword = const PasswordInput.pure(),
    this.email = const EmailInput.pure(),
    this.status = FormzStatus.pure,
  });

  RegisterState copyWith({
    NameInput name,
    UsernameInput username,
    PasswordInput password,
    PasswordInput rePassword,
    EmailInput email,
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
