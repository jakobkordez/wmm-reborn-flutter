import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/components/user_card.dart';
import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/profile/cubit/profile_cubit.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({Key key, this.username = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
          authCubit: context.bloc<AuthCubit>(),
          userRepository: context.repository<UserRepository>(),
          username: username),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) return _Profile(user: state.user);

            if (state is ProfileLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(child: FlutterLogo());
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
      onRefresh: () => context.bloc<ProfileCubit>().refresh(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: UserCard(user: user)),
          SliverList(delegate: SliverChildListDelegate(<Widget>[])),
        ],
      ),
    );
  }
}
