import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'flat_card.dart';
import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/cubit/user_cubit.dart';

class LoanListTile extends StatelessWidget {
  final LoanModel loan;

  const LoanListTile({Key key, this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(loan.title ?? 'Loan'),
      subtitle: Text(
          (context.cubit<UserCubit>().state as UserLoaded).user.username ==
                  loan.sender
              ? loan.reciever
              : loan.sender),
      trailing: Text(
        loan.amount.toStringAsFixed(2) + ' €',
        textAlign: TextAlign.end,
        style: TextStyle(
            fontSize: 22,
            color: (context.cubit<UserCubit>().state as UserLoaded)
                        .user
                        .username ==
                    loan.sender
                ? Colors.green
                : Colors.red),
      ),
    );

    return FlatCard(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(20),
        // decoration: BoxDecoration(
        //   border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400])),
        //   color: Theme.of(context).cardColor,
        // ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    loan.sender,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    loan.reciever,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            if (loan.status == 0)
              Text('Pending', style: TextStyle(color: Colors.amber[700]))
            else if (loan.status == 1)
              Text('Accepted', style: TextStyle(color: Colors.green))
            else if (loan.status == -1)
              Text('Declined', style: TextStyle(color: Colors.red)),
            Expanded(
              flex: 1,
              child: Text(
                loan.amount.toStringAsFixed(2) + ' €',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 22,
                    color: (context.cubit<UserCubit>().state as UserLoaded)
                                .user
                                .username ==
                            loan.sender
                        ? Colors.green
                        : Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
