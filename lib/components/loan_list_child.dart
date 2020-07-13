import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:wmm_reborn_flutter/models/loan.dart';
import 'package:wmm_reborn_flutter/pages/home/cubit/home_cubit.dart';

class LoanListChildWidget extends StatelessWidget {
  final LoanModel loan;

  const LoanListChildWidget({Key key, this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
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
                    color: (context.cubit<HomeCubit>().state as HomeLoaded)
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
