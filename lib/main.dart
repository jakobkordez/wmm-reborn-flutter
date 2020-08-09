import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';
import 'cubit/loan_cubit.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/friend_cubit.dart';
import 'pages/main/main_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';
import 'repositories/loan_repository.dart';
import 'repositories/base_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/friend_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BaseRepository>(
          create: (context) => BaseRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepository(context.repository<BaseRepository>()),
        ),
        RepositoryProvider<LoanRepository>(
          create: (context) =>
              LoanRepository(context.repository<BaseRepository>()),
        ),
        RepositoryProvider<FriendRepository>(
          create: (context) => FriendRepository(
            context.repository<BaseRepository>(),
            context.repository<UserRepository>(),
          ),
        ),
      ],
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(
          baseRepository: context.repository<BaseRepository>(),
          userRepository: context.repository<UserRepository>(),
        ),
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where\'s my money?',
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<UserCubit>(
                  create: (context) => UserCubit(
                    authCubit: context.bloc<AuthCubit>(),
                    userRepository: context.repository<UserRepository>(),
                  ),
                ),
                BlocProvider<LoanCubit>(
                  create: (context) => LoanCubit(
                    authCubit: context.bloc<AuthCubit>(),
                    loanRepository: context.repository<LoanRepository>(),
                  ),
                ),
                BlocProvider<FriendCubit>(
                  create: (context) => FriendCubit(
                    authCubit: context.bloc<AuthCubit>(),
                    friendRepository: context.repository<FriendRepository>(),
                  ),
                ),
              ],
              child: MainPage(),
            );
          }

          if (state is AuthFailure) {
            return LoginPage();
          }

          return SplashPage();
        },
      ),
    );
  }
}
