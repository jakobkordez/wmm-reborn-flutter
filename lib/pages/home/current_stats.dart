import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:wmm_reborn_flutter/models/user.dart';

class CurrentStats extends StatelessWidget {
  final UserModel user;

  const CurrentStats({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            _Stats(
              title: 'You\'re owed',
              amount: user.currentLent,
              color: Colors.green,
            ),
            VerticalDivider(
              width: 20,
              thickness: 2,
            ),
            _Stats(
              title: 'You owe',
              amount: user.currentBorrowed,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;

  _Stats({@required this.title, @required this.amount, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                amount.toStringAsFixed(2) + ' €',
                style: TextStyle(
                  color: color,
                  fontSize: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
