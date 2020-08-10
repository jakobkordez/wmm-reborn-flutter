import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoanPage extends StatelessWidget {
  final int loanId;

  const LoanPage({Key key, this.loanId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(loanId.toString()),
    );
  }
}
