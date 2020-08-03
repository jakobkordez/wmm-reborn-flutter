import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:wmm_flutter/components/loan_list_child.dart';
import 'package:wmm_flutter/cubit/loan_cubit.dart';

class LoanTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoanTabState();
}

class _LoanTabState extends State<LoanTab> {
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
    return CubitListener<LoanCubit, LoanState>(
      listener: (context, state) {
        if (state is LoanLoadingFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      child: RefreshIndicator(
        onRefresh: () => context.cubit<LoanCubit>().loadInitial(),
        child: Container(
          child: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                title: const Text('Loans', style: TextStyle(fontSize: 18)),
                backgroundColor: Colors.blue[400],
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
              ),
              CubitBuilder<LoanCubit, LoanState>(
                builder: (context, state) {
                  if (state is LoanLoaded) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return index >= state.loans.length
                              ? Center(child: CircularProgressIndicator())
                              : LoanListChildWidget(loan: state.loans[index]);
                        },
                        childCount:
                            state.loans.length + (state.hasMore ? 1 : 0),
                      ),
                    );
                  }

                  if (state is LoanLoadingFailure)
                    return SliverFillRemaining(
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.error_outline, size: 50),
                          Text('Something went wrong')
                        ],
                      )),
                    );

                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
