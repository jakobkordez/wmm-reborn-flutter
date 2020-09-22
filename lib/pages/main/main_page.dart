import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/cubit/user_cubit.dart';
import 'package:wmm_flutter/pages/main/tabs/friends_tab.dart';
import 'package:wmm_flutter/pages/main/tabs/home_tab.dart';
import 'package:wmm_flutter/pages/main/tabs/loans_tab.dart';
import 'package:wmm_flutter/pages/main/tabs/profile_tab.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Where\'s my money?'),
          bottom: TabBar(
            labelPadding: EdgeInsets.all(10),
            tabs: <Widget>[
              const Icon(Icons.home, size: 26),
              const Icon(Icons.import_export, size: 26),
              const Icon(Icons.people, size: 26),
              const Icon(Icons.person, size: 26),
            ],
          ),
        ),
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoadingFailure) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: TabBarView(
            children: <Widget>[
              HomeTab(),
              LoanTab(),
              FriendsTab(),
              ProfileTab(),
            ],
          ),
        ),
      ),
    );
  }
}
