import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:wmm_flutter/components/user_card.dart';
import 'package:wmm_flutter/pages/main/cubit/main_cubit.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration(seconds: 1)),
      child: CubitBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) return UserCard(user: state.user);

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
