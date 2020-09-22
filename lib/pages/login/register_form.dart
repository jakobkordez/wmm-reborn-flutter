import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/register_cubit.dart';
import 'input_field.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
            ),
            BlocListener<RegisterCubit, RegisterState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: const Text('Failed to register')),
                  );
                } else if (state.status.isSubmissionSuccess) {
                  DefaultTabController.of(context).index = 0;
                }
              },
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  if (state.status == FormzStatus.submissionInProgress)
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          _UsernameInput(),
                          _NameInput(),
                          _EmailInput(),
                          _PasswordInput(),
                          _RePasswordInput(),
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.blueAccent,
                            onPressed: () =>
                                context.bloc<RegisterCubit>().submit(),
                            child: const Text("Register"),
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
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context).index = 0;
                    FocusScope.of(context).unfocus();
                  },
                  child: Text(
                    'Login here',
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
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputField(
          key: const Key('registerForm_username'),
          prefixIcon: const Icon(Icons.person),
          labelText: 'Username',
          errorText: state.username.invalid ? 'Invalid username' : null,
          textInputAction: TextInputAction.next,
          onChanged: (value) =>
              context.bloc<RegisterCubit>().setUsername(value),
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return InputField(
          key: const Key('registerForm_name'),
          prefixIcon: const Icon(Icons.person),
          labelText: 'Name',
          errorText: state.name.invalid ? 'Invalid name' : null,
          textInputAction: TextInputAction.next,
          onChanged: (value) => context.bloc<RegisterCubit>().setName(value),
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputField(
          key: const Key('registerForm_email'),
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.mail),
          labelText: 'Email',
          errorText: state.email.invalid ? 'Invalid email' : null,
          textInputAction: TextInputAction.next,
          onChanged: (value) => context.bloc<RegisterCubit>().setEmail(value),
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputField(
          key: const Key('registerForm_password'),
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: const Icon(Icons.vpn_key),
          labelText: 'Password',
          errorText: state.password.invalid ? 'Invalid password' : null,
          textInputAction: TextInputAction.next,
          onChanged: (value) =>
              context.bloc<RegisterCubit>().setPassword(value),
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          obscureText: true,
        );
      },
    );
  }
}

class _RePasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.rePassword != current.rePassword,
      builder: (context, state) {
        return InputField(
          key: const Key('registerForm_rePassword'),
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: const Icon(Icons.vpn_key),
          labelText: 'Repeat Password',
          errorText: state.rePassword.pure ||
                  state.password.value == state.rePassword.value
              ? null
              : 'Passwords don\'t match',
          textInputAction: TextInputAction.done,
          onChanged: (value) =>
              context.bloc<RegisterCubit>().setRePassword(value),
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            context.bloc<RegisterCubit>().submit();
          },
          obscureText: true,
        );
      },
    );
  }
}
