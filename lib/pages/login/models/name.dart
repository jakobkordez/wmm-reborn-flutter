import 'package:formz/formz.dart';

enum NameValidatorError { invalid }

class Name extends FormzInput<String, NameValidatorError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  static final _nameRegex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');

  @override
  NameValidatorError validator(String value) {
    return _nameRegex.hasMatch(value) ? null : NameValidatorError.invalid;
  }
}
