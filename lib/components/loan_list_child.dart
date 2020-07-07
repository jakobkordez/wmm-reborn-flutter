import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:wmm_reborn_flutter/models/loan.dart';

class LoanListChildWidget extends StatelessWidget {
  final LoanModel loan;

  const LoanListChildWidget({Key key, this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: const Text("Yo"),
      ),
    );
  }
}
