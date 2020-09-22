import 'package:formz/formz.dart';

enum AmountValidatorError { empty, invalid, notPositive }

class Amount extends FormzInput<String, AmountValidatorError> {
  const Amount.pure() : super.pure('0.00');
  const Amount.dirty([String value = '0.00']) : super.dirty(value);

  @override
  AmountValidatorError validator(String value) {
    if (value?.isEmpty ?? true) return AmountValidatorError.empty;

    if (!RegExp(r'\d*(\.\d*)?').hasMatch(value))
      return AmountValidatorError.invalid;

    if ((double.parse(value) * 100).truncateToDouble() <= 0)
      return AmountValidatorError.notPositive;

    return null;
  }
}
