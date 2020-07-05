import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_reborn_flutter/bloc/auth_bloc.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              userRepository: userRepository,
              authBloc: BlocProvider.of<AuthBloc>(context)),
          child: LoginForm(),
        ),
      ),
    );
  }
}
