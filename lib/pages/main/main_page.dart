import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/pages/main/tabs/friends_tab.dart';
import 'package:wmm_reborn_flutter/pages/main/tabs/home_tab.dart';
import 'package:wmm_reborn_flutter/pages/main/tabs/loans_tab.dart';
import 'package:wmm_reborn_flutter/pages/profile/profile_page.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'cubit/main_cubit.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<MainCubit>(
      create: (context) => MainCubit(
        authCubit: context.cubit<AuthCubit>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    )),
                icon: Icon(Icons.person),
              )
            ],
            bottom: TabBar(
              labelPadding: EdgeInsets.all(10),
              tabs: <Widget>[
                Icon(Icons.home, size: 26),
                Icon(Icons.import_export, size: 26),
                Icon(Icons.people, size: 26),
                Icon(Icons.settings, size: 26),
              ],
            ),
          ),
          body: CubitListener<MainCubit, MainState>(
            listener: (context, state) {
              if (state is MainError) {
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
                Center(child: Text('Settings')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
