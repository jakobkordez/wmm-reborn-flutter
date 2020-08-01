import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/create_loan_page.dart';
import 'package:wmm_reborn_flutter/pages/main/tabs/loans_tab.dart';
import 'package:wmm_reborn_flutter/pages/profile/profile_page.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'cubit/main_cubit.dart';
import 'current_stats.dart';
import 'nav_bar.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<MainCubit>(
      create: (context) => MainCubit(
        authCubit: context.cubit<AuthCubit>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateLoanPage(),
              )),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: NavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: CubitListener<MainCubit, MainState>(
          listener: (context, state) {
            if (state is MainError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: CubitBuilder<MainCubit, MainState>(
            builder: (context, state) {
              if (state is MainLoaded) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        ),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
                                )),
                            icon: Icon(Icons.person),
                          )
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: CurrentStats(
                          user: state.user,
                        ),
                      ),
                    ];
                  },
                  body: LoanTab(),
                );
              }

              if (state is MainInitial)
                return Center(child: CircularProgressIndicator());

              return Center(child: const FlutterLogo());
            },
          ),
        ),
      ),
    );
  }
}
