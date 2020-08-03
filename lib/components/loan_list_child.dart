import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'flat_card.dart';
import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/pages/main/cubit/main_cubit.dart';

class LoanListChildWidget extends StatelessWidget {
  final LoanModel loan;

  const LoanListChildWidget({Key key, this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatCard(
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
                    color: (context.cubit<MainCubit>().state as MainLoaded)
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
