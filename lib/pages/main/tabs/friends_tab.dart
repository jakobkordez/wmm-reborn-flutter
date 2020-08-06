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
      child: RefreshIndicator(
        onRefresh: () => context.cubit<FriendCubit>().loadInitial(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text('Friends', style: TextStyle(fontSize: 18)),
              backgroundColor: Colors.blue[400],
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
            CubitBuilder<FriendCubit, FriendState>(
              builder: (context, state) {
                if (state is FriendLoaded)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(state.friends[index].name),
                          subtitle: Text(state.friends[index].username),
                        );
                      },
                      childCount: state.friends.length,
                    ),
                  );
                // ListView.builder(
                //   itemCount: state.requests.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       leading: Icon(Icons.person),
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
                          Icon(Icons.error_outline, size: 50),
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
          ],
        ),
      ),
    );
  }
}
