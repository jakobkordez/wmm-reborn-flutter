import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:wmm_reborn_flutter/models/user.dart';

class CurrentStats extends StatelessWidget {
  final UserModel user;

  const CurrentStats({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      elevation: 2,
      color: Theme.of(context).primaryColor,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _Stats(
              title: 'You\'re owed',
              amount: user.currentLent,
              color: Colors.green,
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
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
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
    );
  }
}
