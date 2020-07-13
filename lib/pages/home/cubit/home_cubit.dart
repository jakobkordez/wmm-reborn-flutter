import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/models/user.dart';
import 'package:wmm_reborn_flutter/repositories/base_repository.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    @required this.userRepository,
    @required this.authCubit,
  }) : super(HomeInitial()) {
    _init();
  }

  final UserRepository userRepository;
  final AuthCubit authCubit;

  void _init() async {
    emit(HomeInitial());

    try {
      UserModel user = await userRepository.getUser(getNew: true);
      emit(HomeLoaded(user));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(HomeError('Something went wrong! Try again later.'));
    }
  }
}
