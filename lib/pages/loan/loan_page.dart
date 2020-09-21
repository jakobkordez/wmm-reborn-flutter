import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmm_flutter/pages/loan/cubit/single_loan_cubit.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';

class LoanPage extends StatelessWidget {
  final int loanId;

  const LoanPage({Key key, this.loanId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<SingleLoanCubit>(
        create: (context) => SingleLoanCubit(
          loanId: loanId,
          loanRepository: context.repository<LoanRepository>(),
        ),
        child: BlocBuilder<SingleLoanCubit, SingleLoanState>(
          builder: (context, state) {
            if (state is SingleLoanLoaded) return Text(state.loan.title);

            return Text('yuh');
          },
        ),
      ),
    );
  }
}
