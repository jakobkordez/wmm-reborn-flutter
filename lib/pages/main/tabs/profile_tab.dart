import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/components/user_card.dart';
import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/cubit/user_cubit.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.bloc<UserCubit>().loadInitial(),
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded)
                return SliverToBoxAdapter(
                  child: UserCard(user: state.user),
                );

              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          SliverToBoxAdapter(
            child: FlatButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout?'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    FlatButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    FlatButton(
                      child: const Text('Logout'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.bloc<AuthCubit>().logout();
                      },
                    ),
                  ],
                ),
              ),
              padding: EdgeInsets.all(15),
              textColor: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.exit_to_app),
                  const Text('Logout'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
