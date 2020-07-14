import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/components/loan_list_child.dart';
import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/cubit/loan_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/create_loan_page.dart';
import 'package:wmm_reborn_flutter/pages/profile/profile_page.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'cubit/main_cubit.dart';
import 'current_stats.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold)
      context.cubit<LoanCubit>().loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _FlatButton(icon: Icon(Icons.home), text: "Home"),
                    _FlatButton(icon: Icon(Icons.people), text: "Friends"),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _FlatButton(icon: Icon(Icons.list), text: "Loans"),
                    _FlatButton(icon: Icon(Icons.settings), text: "Settings"),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                  controller: _scrollController,
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
                  body: CubitListener<LoanCubit, LoanState>(
                    listener: (context, state) {
                      if (state is LoanLoadingFailure) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(state.error),
                        ));
                      }
                    },
                    child: CubitBuilder<LoanCubit, LoanState>(
                      builder: (context, state) {
                        if (state is LoanLoaded) {
                          return RefreshIndicator(
                            onRefresh: () =>
                                context.cubit<LoanCubit>().loadInitial(),
                            child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return index >= state.loans.length
                                    ? Center(child: CircularProgressIndicator())
                                    : LoanListChildWidget(
                                        loan: state.loans[index],
                                      );
                              },
                              itemCount:
                                  state.loans.length + (state.hasMore ? 1 : 0),
                            ),
                          );
                        }

                        if (state is LoanLoadingFailure)
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.error_outline, size: 50),
                                FlatButton(
                                  onPressed: () =>
                                      context.cubit<LoanCubit>().loadInitial(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.refresh),
                                      Text('Retry'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );

                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
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

class _FlatButton extends StatelessWidget {
  final String text;
  final Icon icon;

  const _FlatButton({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      padding: EdgeInsets.all(8),
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[icon, Text(text)],
      ),
    );
  }
}
