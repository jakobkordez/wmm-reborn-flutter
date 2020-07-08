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
      color: loan.status == 0
          ? Colors.indigo[100]
          : loan.status == -1 ? Colors.red[100] : Colors.white,
      child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
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
            Text(
              loan.amount.toStringAsFixed(2) + ' €',
              style: TextStyle(
                  fontSize: 26,
                  color: (context.cubit<HomeCubit>().state as HomeLoaded)
                              .user
                              .username ==
                          loan.sender
                      ? Colors.green
                      : Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
