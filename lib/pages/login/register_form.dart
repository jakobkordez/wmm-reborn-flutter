import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:wmm_flutter/repositories/user_repository.dart';

import 'cubit/register_cubit.dart';
import 'input_field.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(
        userRepository: context.repository<UserRepository>(),
      ),
      child: SingleChildScrollView(
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
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to register'),
                    ));
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
                            InputField(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Username",
                              errorText:
                                  state.username.pure || state.username.valid
                                      ? null
                                      : 'Invalid username',
                              textInputAction: TextInputAction.next,
                              onChanged: (value) => context
                                  .bloc<RegisterCubit>()
                                  .onUsernameChanged(value),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            InputField(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Name",
                              errorText: state.name.pure || state.name.valid
                                  ? null
                                  : 'Invalid name',
                              textInputAction: TextInputAction.next,
                              onChanged: (value) => context
                                  .bloc<RegisterCubit>()
                                  .onNameChanged(value),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            InputField(
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(Icons.mail),
                              labelText: "Email",
                              errorText: state.email.pure || state.email.valid
                                  ? null
                                  : 'Invalid email',
                              textInputAction: TextInputAction.next,
                              onChanged: (value) => context
                                  .bloc<RegisterCubit>()
                                  .onEmailChanged(value),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            InputField(
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icon(Icons.vpn_key),
                              labelText: "Password",
                              errorText:
                                  state.password.pure || state.password.valid
                                      ? null
                                      : 'Invalid password',
                              textInputAction: TextInputAction.next,
                              onChanged: (value) => context
                                  .bloc<RegisterCubit>()
                                  .onPasswordChanged(value),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              obscureText: true,
                            ),
                            InputField(
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icon(Icons.vpn_key),
                              labelText: "Repeat Password",
                              errorText: state.rePassword.pure ||
                                      state.password.value ==
                                          state.rePassword.value
                                  ? null
                                  : 'Passwords don\'t match',
                              textInputAction: TextInputAction.done,
                              onChanged: (value) => context
                                  .bloc<RegisterCubit>()
                                  .onRepeatPasswordChanged(value),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                                context.bloc<RegisterCubit>().register();
                              },
                              obscureText: true,
                            ),
                            FlatButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () =>
                                  context.bloc<RegisterCubit>().register(),
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
                  Text('Already have an account? '),
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
      ),
    );
  }
}
