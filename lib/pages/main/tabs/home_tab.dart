import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/cubit/user_cubit.dart';
import '../current_stats.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded)
          return RefreshIndicator(
            onRefresh: () => context.bloc<UserCubit>().loadInitial(),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: CurrentStats(user: state.user),
                )
              ],
            ),
          );

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
