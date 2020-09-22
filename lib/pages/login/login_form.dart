import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/login_cubit.dart';
import 'input_field.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
            ),
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: const Text('Failed to login')),
                  );
                }
              },
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state.status.isSubmissionInProgress) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          _UsernameInput(),
                          _PasswordInput(),
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.blueAccent,
                            onPressed: () =>
                                context.bloc<LoginCubit>().submit(),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account yet? '),
                GestureDetector(
                  onTap: () => DefaultTabController.of(context).index = 1,
                  child: Text(
                    'Register here',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputField(
          key: const Key('loginForm_username'),
          prefixIcon: const Icon(Icons.person),
          labelText: 'Username',
          textInputAction: TextInputAction.next,
          onChanged: (value) => context.bloc<LoginCubit>().setUsername(value),
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputField(
          key: const Key('loginForm_password'),
          prefixIcon: const Icon(Icons.vpn_key),
          labelText: 'Password',
          textInputAction: TextInputAction.done,
          onChanged: (value) => context.bloc<LoginCubit>().setPassword(value),
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            if (state.status.isValid) context.bloc<LoginCubit>().submit();
          },
          obscureText: true,
        );
      },
    );
  }
}
