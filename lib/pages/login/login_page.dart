import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

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
        child: CubitProvider(
          create: (context) => LoginCubit(
            authCubit: context.cubit<AuthCubit>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
