import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmm_reborn_flutter/routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        // BlocProvider<AuthBloc>(bloc: AuthBloc()),
      ],
      child: MaterialApp(
        title: 'Where\'s my money?',
        theme: ThemeData.dark(),
        initialRoute: '/login',
        routes: routes,
      ),
    );
  }

}