import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'cubit/loan_cubit.dart';
import 'repositories/loan_repository.dart';
import 'cubit/auth_cubit.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';
import 'repositories/base_repository.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          Provider<BaseRepository>(create: (context) => BaseRepository()),
          Provider<UserRepository>(
            create: (context) => UserRepository(context.read<BaseRepository>()),
          ),
          Provider<LoanRepository>(
            create: (context) => LoanRepository(context.read<BaseRepository>()),
          ),
        ],
        child: MultiCubitProvider(
          providers: [
            CubitProvider<AuthCubit>(
              create: (context) => AuthCubit(
                baseRepository: context.read<BaseRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            CubitProvider<LoanCubit>(
              create: (context) => LoanCubit(
                authCubit: context.cubit<AuthCubit>(),
                loanRepository: context.read<LoanRepository>(),
              ),
            ),
          ],
          child: App(),
        )),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where\'s my money?',
      home: CubitBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return HomePage();
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
