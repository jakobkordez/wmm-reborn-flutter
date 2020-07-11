import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';
import 'package:wmm_reborn_flutter/components/basic_drawer.dart';

import 'package:wmm_reborn_flutter/components/loan_list_child.dart';
import 'package:wmm_reborn_flutter/cubit/auth_cubit.dart';
import 'package:wmm_reborn_flutter/cubit/loan_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/create_loan_page.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

import 'cubit/home_cubit.dart';
import 'current_stats.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return CubitProvider<HomeCubit>(
      create: (context) => HomeCubit(
        authCubit: context.cubit<AuthCubit>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        drawer: BasicDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateLoanPage(),
              )),
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
                  controller: _scrollController,
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
                    CubitBuilder<LoanCubit, LoanState>(
                      builder: (context, state) {
                        if (state is LoanLoaded) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return index >= state.loans.length
                                    ? Center(child: CircularProgressIndicator())
                                    : LoanListChildWidget(
                                        loan: state.loans[index],
                                      );
                              },
                              childCount:
                                  state.loans.length + (state.hasMore ? 1 : 0),
                            ),
                          );
                        }

                        return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ],
                );
              }

              if (state is HomeInitial)
                return Center(child: CircularProgressIndicator());

              return Center(child: const FlutterLogo());
            },
          ),
        ),
      ),
    );
  }
}
