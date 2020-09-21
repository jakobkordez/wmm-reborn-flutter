import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    @required this.authCubit,
    @required this.username,
    @required this.userRepository,
  }) : super(ProfileInitial()) {
    loadProfile();
  }

  final AuthCubit authCubit;
  final UserRepository userRepository;
  final String username;

  void loadProfile() async {
    emit(ProfileLoading());

    try {
      final user = await userRepository.getUser(username: username);
      await Future.delayed(Duration(milliseconds: 0));
      emit(ProfileLoaded(user));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(ProfileFailure('Something went wrong! Try again later.'));
    }
  }

  Future<void> refresh() async {
    emit(ProfileLoading());

    try {
      final user =
          await userRepository.getUser(getNew: true, username: username);
      emit(ProfileLoaded(user));
    } on UnauthorizedError {
      authCubit.logout();
    } on Error {
      emit(ProfileFailure('Something went wrong! Try again later.'));
    }
  }
}
