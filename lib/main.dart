import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'cubit/auth_cubit.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          Provider<UserRepository>(
            create: (context) => UserRepository(),
          )
        ],
        child: MultiCubitProvider(
          providers: [
            CubitProvider(
              create: (context) =>
                  AuthCubit(userRepository: context.read<UserRepository>()),
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
