import 'package:formz/formz.dart';

enum EmailInputError { invalid }

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
      r'^((?!.*\.\.)(?!\.)(?!.*\.@)([a-zA-Z\d\.\+\_$#!&%?-]+)@(((?!-)(?!.*-\.)([a-zA-Z\d-]+)\.([a-z]{2,8})(\.[a-z]{2,8})?)|(\[(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\])))$');

  @override
  EmailInputError validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailInputError.invalid;
  }
}
