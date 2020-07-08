import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'cubit/auth_cubit.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';
import 'repositories/base_repository.dart';
import 'repositories/user_repository.dart';

void main() {
  BaseRepository baseRepository = BaseRepository();

  runApp(
    MultiProvider(
        providers: [
          Provider<BaseRepository>(create: (context) => baseRepository),
          Provider<UserRepository>(
            create: (context) => UserRepository(context.read<BaseRepository>()),
          )
        ],
        child: MultiCubitProvider(
          providers: [
            CubitProvider(
              create: (context) => AuthCubit(
                baseRepository: context.read<BaseRepository>(),
                userRepository: context.read<UserRepository>(),
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
