import 'package:formz/formz.dart';

enum UsernameValidatorError { invalid }

class Username extends FormzInput<String, UsernameValidatorError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _usernameRegex = RegExp(r'^[\w.]{5,20}$');

  @override
  UsernameValidatorError validator(String value) {
    return _usernameRegex.hasMatch(value)
        ? null
        : UsernameValidatorError.invalid;
  }
}
