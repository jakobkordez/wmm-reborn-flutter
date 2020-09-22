import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:wmm_flutter/models/user.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        user.username,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, height: 40),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _amount(user.totalLent, Colors.green),
                    _amount(user.totalBorrowed, Colors.red),
                  ],
                ),
                _label('Total'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _label('Lent'),
                    _label('Borrowed'),
                  ],
                ),
                _label('Current'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _amount(user.currentLent, Colors.green),
                    _amount(user.currentBorrowed, Colors.red),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _label(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }

  _amount(double amount, Color color) {
    return Text(
      amount.toStringAsFixed(2) + ' €',
      style: TextStyle(color: color, fontSize: 24),
    );
  }
}
