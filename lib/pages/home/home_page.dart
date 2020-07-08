import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/components/loan_list_child.dart';
import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'cubit/home_cubit.dart';
import 'current_stats.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<HomeCubit>(
      create: (context) => HomeCubit(
        authCubit: context.cubit<AuthCubit>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () => context.cubit<AuthCubit>().logout(),
                child: const Text("Logout"),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add),
        ),
        body: CubitListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: CubitBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      title: const Text('Home'),
                      centerTitle: true,
                    ),
                    SliverToBoxAdapter(
                      child: CurrentStats(
                        user: state.user,
                      ),
                    ),
                    SliverToBoxAdapter(child: Divider()),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => LoanListChildWidget(),
                          childCount: 10),
                    ),
                  ],
                );
              }

              if (state is HomeInitial)
                return Center(child: CircularProgressIndicator());

              return Center(
                child: const FlutterLogo(),
              );
            },
          ),
        ),
      ),
    );
  }
}
