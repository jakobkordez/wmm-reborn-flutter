import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';

import 'package:wmm_flutter/models/user.dart';

import 'base_repository.dart';

class UserRepository {
  UserRepository(this.baseRepository);

  final BaseRepository baseRepository;

  String get basePath => '/users';

  Map<String, UserModel> _cachedUsers = {};

  Future<bool> login(
      {@required String username, @required String password}) async {
    Response res = await baseRepository.send(
      'POST',
      '$basePath/login',
      identify: false,
      body: {'username': username, 'password': password},
    );

    if (res.statusCode == 400) return false;

    if (res.statusCode != 200) throw Error();

    await baseRepository.persistToken(json.decode(res.body)['refresh_token']);

    return true;
  }

  Future<void> logout() async {
    try {
      final refreshToken = await baseRepository.getToken();
      await baseRepository.send('DELETE', '$basePath/token',
          body: {'refresh_token': refreshToken});
    } finally {
      await baseRepository.deleteToken();
    }
  }

  Future<UserModel> getUser({bool getNew = false, String username = ''}) async {
    if (!getNew && _cachedUsers[username] != null)
      return _cachedUsers[username];

    Response res =
        await baseRepository.send('GET', '$basePath/profile/$username');

    if (res.statusCode != 200) throw Error();

    final user = UserModel.fromJson(json.decode(res.body));
    _cachedUsers[user.username] = user;
    if (username == '') _cachedUsers[''] = user;

    return user;
  }

  Future<List<UserModel>> searchUsers(String phrase) async {
    Response res = await baseRepository.send('GET', '$basePath/search/$phrase');

    if (res.statusCode != 200) throw Error();

    final usernames = json.decode(res.body) as List<dynamic>;

    return Future.wait(usernames.map((e) => getUser(username: e)));
  }
}
