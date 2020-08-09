import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _onLoginButtonPressed() {
    context.bloc<LoginCubit>().login(
          username: _usernameController.text,
          password: _passwordController.text,
        );
  }

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
              listener: (context, state) {
                if (state is LoginFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginInProgress) {
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
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                prefixIcon: Icon(Icons.person),
                                labelText: "Username"),
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(context).nextFocus(),
                          ),
                          Container(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: "Password"),
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).unfocus();
                              if (_usernameController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty)
                                _onLoginButtonPressed();
                            },
                            obscureText: true,
                          ),
                          Container(height: 10),
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () => _onLoginButtonPressed(),
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
                Text('Don\'t have an account yet? '),
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
