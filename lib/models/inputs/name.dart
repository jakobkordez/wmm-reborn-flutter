import 'package:formz/formz.dart';

enum NameInputError { invalid }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  static final _nameRegex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');

  @override
  NameInputError validator(String value) {
    return _nameRegex.hasMatch(value) ? null : NameInputError.invalid;
  }
}
