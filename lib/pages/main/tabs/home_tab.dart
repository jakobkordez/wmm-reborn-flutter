import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:wmm_flutter/pages/main/cubit/main_cubit.dart';
import '../current_stats.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<MainCubit, MainState>(
      builder: (context, state) {
        if (state is MainLoaded)
          return RefreshIndicator(
            onRefresh: () => Future.delayed(Duration(seconds: 2)),
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
