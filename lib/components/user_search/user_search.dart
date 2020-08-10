import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wmm_flutter/components/user_search/cubit/user_search_cubit.dart';
import 'package:wmm_flutter/components/user_tile.dart';
import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

class UserSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSearchCubit>(
      create: (context) => UserSearchCubit(
        authCubit: context.bloc<AuthCubit>(),
        userRepository: context.repository<UserRepository>(),
      ),
      child: BlocListener<UserSearchCubit, UserSearchState>(
        listener: (context, state) {
          if (state is UserSearchFailure)
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _SearchInput()),
            BlocBuilder<UserSearchCubit, UserSearchState>(
              builder: (context, state) {
                if (state is UserSearchFound)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => UserTile(user: state.users[index]),
                      childCount: state.users.length,
                    ),
                  );

                return SliverToBoxAdapter(
                  child: Container(height: 0, width: 0),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  TextEditingController _controller;
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce.cancel();
        if (value.length < 3) return;
        _debounce = Timer(
          Duration(milliseconds: 500),
          () => context.bloc<UserSearchCubit>().search(value),
        );
      },
      decoration: InputDecoration(
        hintText: 'Search user',
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.cancel,
            color: Colors.grey,
          ),
          onTap: () => _controller.clear(),
        ),
        fillColor: Colors.grey[100],
        filled: true,
      ),
    );
  }
}
