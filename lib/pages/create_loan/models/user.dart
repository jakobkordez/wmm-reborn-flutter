import 'package:formz/formz.dart';
import 'package:wmm_flutter/models/user.dart';

enum UserValidatorError { empty }

class User extends FormzInput<UserModel, UserValidatorError> {
  const User.pure() : super.dirty(UserModel.empty);
  const User.dirty([UserModel value]) : super.dirty(value);

  @override
  UserValidatorError validator(UserModel value) {
    return value != UserModel.empty ? null : UserValidatorError.empty;
  }
}
