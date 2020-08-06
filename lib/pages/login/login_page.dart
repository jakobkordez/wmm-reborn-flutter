import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

import 'cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
            authCubit: context.bloc<AuthCubit>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
