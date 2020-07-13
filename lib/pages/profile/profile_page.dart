import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';
import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';

import 'package:wmm_reborn_flutter/models/user.dart';
import 'package:wmm_reborn_flutter/pages/profile/cubit/profile_cubit.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({Key key, this.username = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
          authCubit: context.cubit<AuthCubit>(),
          userRepository: context.read<UserRepository>(),
          username: username),
      child: Scaffold(
        appBar: AppBar(),
        body: CubitBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) return _Profile(user: state.user);

            if (state is ProfileLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: Text("TEEEEEEEMPORARY"),
            );
          },
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  final UserModel user;

  const _Profile({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.cubit<ProfileCubit>().refresh(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.username),
                  ],
                ),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(<Widget>[])),
        ],
      ),
    );
  }
}
