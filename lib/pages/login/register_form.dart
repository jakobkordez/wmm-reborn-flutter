import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  Map<String, TextEditingController> _controllers = Map();

  @override
  void initState() {
    super.initState();
    _controllers['username'] = TextEditingController();
    _controllers['password'] = TextEditingController();
    _controllers['repeat_pass'] = TextEditingController();
    _controllers['email'] = TextEditingController();
    _controllers['name'] = TextEditingController();
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
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
                listener: (context, state) {
                  // TODO: implement listener
                },
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    // TODO: implement states
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
                              controller: _controllers['username'],
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            Container(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  prefixIcon: Icon(Icons.person),
                                  labelText: "Name"),
                              controller: _controllers['name'],
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            Container(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  prefixIcon: Icon(Icons.mail),
                                  labelText: "Email"),
                              controller: _controllers['email'],
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
                              controller: _controllers['password'],
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              obscureText: true,
                            ),
                            Container(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  prefixIcon: Icon(Icons.vpn_key),
                                  labelText: "Repeat Password"),
                              controller: _controllers['rePassword'],
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
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
                              onPressed: () {},
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
                    onTap: () => DefaultTabController.of(context).index = 0,
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
