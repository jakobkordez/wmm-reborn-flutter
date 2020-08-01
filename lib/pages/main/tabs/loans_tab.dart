import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:wmm_reborn_flutter/components/loan_list_child.dart';
import 'package:wmm_reborn_flutter/cubit/loan_cubit.dart';

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
      child: CubitBuilder<LoanCubit, LoanState>(
        builder: (context, state) {
          if (state is LoanLoaded) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.cubit<LoanCubit>().loadInitial(),
              child: ListView.builder(
                controller: _scrollController,
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
    );
  }
}