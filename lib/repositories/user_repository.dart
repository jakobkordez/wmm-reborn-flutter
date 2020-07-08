import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';

import 'package:wmm_reborn_flutter/models/user.dart';

import 'base_repository.dart';

class UserRepository {
  UserRepository(this.baseRepository);

  final BaseRepository baseRepository;

  String get baseUrl => '/users';

  UserModel _currentUser;

  Future<bool> login(
      {@required String username, @required String password}) async {
    Response res = await baseRepository.send(
      'POST',
      '$baseUrl/login',
      identify: false,
      body: {'username': username, 'password': password},
    );

    if (res.statusCode / 100 == 4) return false;

    if (res.statusCode / 100 != 2) throw Error();

    await baseRepository.persistToken(json.decode(res.body)['refresh_token']);

    return true;
  }

  Future<void> logout() async {
    await baseRepository.deleteToken();
  }

  Future<UserModel> getCurrentUser({bool getNew = false}) async {
    if (!getNew && _currentUser != null) return _currentUser;

    Response res = await baseRepository.send('GET', '$baseUrl/profile');

    if (res.statusCode != 200) throw Error();

    return _currentUser = UserModel.fromJson(json.decode(res.body));
  }
}
