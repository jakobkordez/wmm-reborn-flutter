import 'package:flutter/material.dart';

class FlatCard extends StatelessWidget {
  final Widget child;

  const FlatCard({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
    );
  }
}
