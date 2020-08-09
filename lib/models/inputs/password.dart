import 'package:formz/formz.dart';

enum PasswordInputError { invalid }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(r'^[\w.#$%&@\- ]{6,}$');

  @override
  PasswordInputError validator(String value) {
    return _passwordRegex.hasMatch(value) ? null : PasswordInputError.invalid;
  }
}
