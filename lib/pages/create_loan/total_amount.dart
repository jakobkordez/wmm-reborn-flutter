import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalAmount extends StatelessWidget {
  final double total, lent, borrowed;

  const TotalAmount({
    Key key,
    this.total = 0,
    this.lent = 0,
    this.borrowed = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            const _Label(text: 'Total'),
            Text(
              total.toStringAsFixed(2) + ' €',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const _Label(text: 'Lent'),
                    Text(
                      lent.toStringAsFixed(2) + ' €',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    const _Label(text: 'Borrowed'),
                    Text(
                      borrowed.toStringAsFixed(2) + ' €',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[600], fontSize: 14),
    );
  }
}
