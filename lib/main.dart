import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<UserRepository>(
        create: (context) => UserRepository(),
      )
    ],
    child: MultiBlocProvider(providers: <BlocProvider>[
      BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<UserRepository>(context))
              ..add(AuthStarted()),
      )
    ], child: App()),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where\'s my money?',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return HomePage();
          }

          if (state is AuthFailure) {
            return LoginPage(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          }

          if (state is AuthInProgress) {
            return CircularProgressIndicator();
          }

          return Text('Splash screen');
        },
      ),
    );
  }
}
