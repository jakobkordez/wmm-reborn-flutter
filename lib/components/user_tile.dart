import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/profile/profile_page.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.username),
        leading: Icon(Icons.person),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(username: user.username),
          ),
        ),
      ),
    );
  }
}
