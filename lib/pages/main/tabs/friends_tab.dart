import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:wmm_reborn_flutter/cubit/friend_cubit.dart';

class FriendsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitListener<FriendCubit, FriendState>(
      listener: (context, state) {},
      child: CubitBuilder<FriendCubit, FriendState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              DefaultTabController(
                length: 2,
                child: TabBar(
                  tabs: <Widget>[
                    Center(
                      child: FlutterLogo(),
                    ),
                    Center(
                      child: FlutterLogo(),
                    ),
                  ],
                ),
              ),
              Text("yo"),
            ],
          );
        },
      ),
    );
  }
}
