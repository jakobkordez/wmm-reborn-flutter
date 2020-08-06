import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:wmm_flutter/components/user_search/user_search.dart';

class AddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friends'),
        centerTitle: true,
      ),
      body: UserSearch(),
    );
  }
}
