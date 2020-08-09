import 'package:formz/formz.dart';

enum UsernameInputError { invalid }

class UsernameInput extends FormzInput<String, UsernameInputError> {
  const UsernameInput.pure() : super.pure('');
  const UsernameInput.dirty([String value = '']) : super.dirty(value);

  static final _usernameRegex = RegExp(r'^[\w.]{5,20}$');

  @override
  UsernameInputError validator(String value) {
    return _usernameRegex.hasMatch(value) ? null : UsernameInputError.invalid;
  }
}
