import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:wmm_flutter/cubit/friend_cubit.dart';

class FriendsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitListener<FriendCubit, FriendState>(
      listener: (context, state) {
        if (state is FriendLoadingFailure)
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
      },
      child: CubitBuilder<FriendCubit, FriendState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.black,
                    labelPadding: EdgeInsets.all(8),
                    tabs: <Widget>[
                      Text('All'),
                      Text('Requests'),
                    ],
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
