import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/profile/profile_page.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final void Function() onTap;
  final Color color;

  const UserTile({
    Key key,
    this.user,
    this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  void _onTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            username: user.username,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || user == UserModel.empty)
      return Container(
        color: color,
        child: ListTile(
          title: const Text('No user'),
          leading: const Icon(Icons.person_outline),
          onTap: onTap,
        ),
      );

    return Container(
      color: color,
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.username),
        leading: const Icon(Icons.person),
        onTap: onTap ?? () => _onTap(context),
      ),
    );
  }
}
