import 'package:formz/formz.dart';

enum PasswordValidatorError { invalid }

class Password extends FormzInput<String, PasswordValidatorError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(r'^[\w.#$%&@\- ]{6,}$');

  @override
  PasswordValidatorError validator(String value) {
    return _passwordRegex.hasMatch(value)
        ? null
        : PasswordValidatorError.invalid;
  }
}
