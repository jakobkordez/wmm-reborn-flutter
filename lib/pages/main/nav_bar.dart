import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _NavBarButton(icon: Icon(Icons.home), text: "Home"),
                _NavBarButton(icon: Icon(Icons.people), text: "Friends"),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _NavBarButton(icon: Icon(Icons.list), text: "Loans"),
                _NavBarButton(icon: Icon(Icons.settings), text: "Settings"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  final String text;
  final Icon icon;

  const _NavBarButton({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      padding: EdgeInsets.all(8),
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[icon, Text(text)],
      ),
    );
  }
}
