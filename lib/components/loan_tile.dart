import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/cubit/user_cubit.dart';
import 'package:wmm_flutter/pages/loan/loan_page.dart';

class LoanTile extends StatelessWidget {
  final LoanModel loan;

  const LoanTile({Key key, this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(loan.title ?? 'Loan'),
        subtitle: Text(
            (context.bloc<UserCubit>().state as UserLoaded).user.username ==
                    loan.sender
                ? loan.reciever
                : loan.sender),
        trailing: Text(
          loan.amount.toStringAsFixed(2) + ' €',
          textAlign: TextAlign.end,
          style: TextStyle(
              fontSize: 22,
              color: (context.bloc<UserCubit>().state as UserLoaded)
                          .user
                          .username ==
                      loan.sender
                  ? Colors.green
                  : Colors.red),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoanPage(loanId: loan.id),
          ),
        ),
      ),
    );
  }
}
