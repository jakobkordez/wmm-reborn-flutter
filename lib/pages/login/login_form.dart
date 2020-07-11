import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      context.cubit<LoginCubit>().loginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text);
    }

    return CubitListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: CubitBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInProgress) {
            return CircularProgressIndicator();
          }

          return Form(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: "Username"),
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(),
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
    );
  }
}
