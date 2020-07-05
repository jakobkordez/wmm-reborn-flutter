import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

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
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
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
      child: BlocBuilder<LoginBloc, LoginState>(
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
                      _onLoginButtonPressed();
                    },
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () => _onLoginButtonPressed(),
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
