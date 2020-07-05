import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import '../../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  final UserRepository userRepository;

  const HomePage({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () =>
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut()),
          child: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }
}
