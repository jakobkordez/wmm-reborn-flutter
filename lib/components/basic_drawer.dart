import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';

class BasicDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () => context.cubit<AuthCubit>().logout(),
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}
