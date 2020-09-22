import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/components/user_tile.dart';
import 'package:wmm_flutter/cubit/friend_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/add_friend/add_friend_page.dart';

class FriendList extends StatelessWidget {
  final void Function(UserModel user) onTap;

  const FriendList({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendCubit, FriendState>(
      listener: (context, state) {
        if (state is FriendLoadingFailure)
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
      },
      child: RefreshIndicator(
        onRefresh: () => context.bloc<FriendCubit>().loadInitial(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text('Friends', style: TextStyle(fontSize: 18)),
              backgroundColor: Colors.blue[400],
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: null,
                ),
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFriendPage()),
                  ),
                ),
              ],
            ),
            BlocBuilder<FriendCubit, FriendState>(
              builder: (context, state) {
                if (state is FriendLoaded)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => UserTile(
                        user: state.friends[index],
                        onTap: onTap != null
                            ? () => onTap(state.friends[index])
                            : null,
                      ),
                      childCount: state.friends.length,
                    ),
                  );
                // ListView.builder(
                //   itemCount: state.requests.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       leading: const Icon(Icons.person),
                //       title: Text(state.requests[index].name),
                //       subtitle: Text(state.requests[index].username),
                //     );
                //   },
                // ),

                if (state is FriendLoadingFailure)
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.error_outline, size: 50),
                          Text(state.error),
                        ],
                      ),
                    ),
                  );

                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.grey[700]),
                child: BlocBuilder<FriendCubit, FriendState>(
                  builder: (context, state) {
                    if (state is FriendLoaded) {
                      if (state.friends.length == 0)
                        return Padding(
                          padding: const EdgeInsets.all(40),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: const Text('No friends yet.'),
                          ),
                        );
                    }

                    return Container(width: 0, height: 0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
