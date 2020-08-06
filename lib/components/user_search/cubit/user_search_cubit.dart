import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit({
    @required this.authCubit,
    @required this.userRepository,
  }) : super(UserSearchInitial());

  final AuthCubit authCubit;
  final UserRepository userRepository;

  Future<void> search(String phrase) async {
    if (phrase == '') return emit(UserSearchInitial());

    emit(UserSearchLoading());
    try {
      List<UserModel> users = await userRepository.searchUsers(phrase);
      if (users.isEmpty)
        emit(UserSearchEmpty());
      else
        emit(UserSearchFound(users));
    } on ArgumentError {
      emit(UserSearchEmpty());
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(UserSearchFailure('Something went wrong! Try again later.'));
    }
  }
}
