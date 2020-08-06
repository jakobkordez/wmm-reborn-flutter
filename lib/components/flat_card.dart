import 'package:flutter/material.dart';

class FlatCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;

  const FlatCard({
    Key key,
    this.child,
    this.margin = const EdgeInsets.only(bottom: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
      elevation: 0,
      margin: margin,
      shape: RoundedRectangleBorder(),
    );
  }
}
