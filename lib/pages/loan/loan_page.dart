import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:wmm_flutter/components/user_tile.dart';
import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/loan/cubit/loan_page_cubit.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

class LoanPage extends StatelessWidget {
  final int loanId;

  const LoanPage({Key key, this.loanId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanPageCubit(
        loanId: loanId,
        userRepository: context.repository<UserRepository>(),
        loanRepository: context.repository<LoanRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () => context.bloc<LoanPageCubit>().loadLoan(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<LoanPageCubit, LoanPageState>(
                builder: (context, state) {
                  if (state is LoanPageLoaded)
                    return _Loan(loan: state.loan, other: state.other);

                  if (state is LoanPageFailure)
                    return Center(child: Icon(Icons.help));

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Loan extends StatelessWidget {
  final LoanModel loan;
  final UserModel other;

  const _Loan({Key key, @required this.loan, this.other}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            loan.title ?? "No title",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
          ),
          Padding(padding: const EdgeInsets.all(12)),
          UserTile(user: other),
          Padding(padding: const EdgeInsets.all(6)),
          Icon(
            other.username == loan.reciever
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: other.username == loan.reciever ? Colors.green : Colors.red,
            size: 34,
          ),
          Padding(padding: const EdgeInsets.all(6)),
          Text(
            "${loan.amount.toStringAsFixed(2)} €",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color:
                  other.username == loan.reciever ? Colors.green : Colors.red,
            ),
          ),
          Padding(padding: const EdgeInsets.all(12)),
          Text(
            DateFormat.yMEd().add_Hm().format(loan.created),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
