import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({
    @required this.userRepository,
    @required this.authCubit,
  }) : super(MainInitial()) {
    _init();
  }

  final UserRepository userRepository;
  final AuthCubit authCubit;

  void _init() async {
    emit(MainInitial());

    try {
      UserModel user = await userRepository.getUser(getNew: true);
      emit(MainLoaded(user));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(MainError('Something went wrong! Try again later.'));
    }
  }
}
