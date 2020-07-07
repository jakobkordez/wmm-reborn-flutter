import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:wmm_reborn_flutter/components/loan_list_child.dart';
import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';

import 'cubit/home_cubit.dart';
import 'current_stats.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.cubit<AuthCubit>().logout(),
            child: const Icon(Icons.exit_to_app),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: const Text('Home'),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: CurrentStats(
                  user: null, // TODO: Read from state
                ),
              ),
              SliverToBoxAdapter(child: Divider()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => LoanListChildWidget(),
                    childCount: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
