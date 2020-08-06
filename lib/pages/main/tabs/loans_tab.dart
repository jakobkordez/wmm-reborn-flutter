import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmm_flutter/components/loan_list_tile.dart';
import 'package:wmm_flutter/cubit/loan_cubit.dart';
import 'package:wmm_flutter/pages/create_loan/create_loan_page.dart';

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
      context.bloc<LoanCubit>().loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoanCubit, LoanState>(
      listener: (context, state) {
        if (state is LoanLoadingFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      child: RefreshIndicator(
        onRefresh: () => context.bloc<LoanCubit>().loadInitial(),
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
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateLoanPage()),
                  ),
                ),
              ],
            ),
            BlocBuilder<LoanCubit, LoanState>(
              builder: (context, state) {
                if (state is LoanLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return index >= state.loans.length
                            ? Center(child: CircularProgressIndicator())
                            : LoanListTile(loan: state.loans[index]);
                      },
                      childCount: state.loans.length + (state.hasMore ? 1 : 0),
                    ),
                  );
                }

                if (state is LoanLoadingFailure)
                  return SliverFillRemaining(
                    hasScrollBody: false,
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
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.grey[700]),
                child: Container(
                  color: Colors.grey[300],
                  child: BlocBuilder<LoanCubit, LoanState>(
                    builder: (context, state) {
                      if (state is LoanLoaded) {
                        if (state.loans.length == 0)
                          return Center(child: Text('No loans yet.'));

                        return Center(child: Text('No more loans.'));
                      }

                      return Container(width: 0, height: 0);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
