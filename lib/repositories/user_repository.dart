import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:wmm_reborn_flutter/models/user.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  String get baseUrl => super.baseUrl + '/users';

  UserModel _currentUser;
  String _accessToken;

  Future<bool> authenticate(
      {@required String username, @required String password}) async {
    Response res = await client.post(baseUrl + '/login',
        body: json.encode({'username': username, 'password': password}),
        headers: headers);

    if (res.statusCode / 100 == 4) return false;

    if (res.statusCode / 100 != 2) throw Error();

    await storage.write(
        key: 'refresh_token', value: json.decode(res.body)['refresh_token']);

    return true;
  }

  Future<void> logout() async {
    await storage.delete(key: 'refresh_token');
  }

  Future<bool> hasToken() async {
    return await storage.read(key: 'refresh_token') != null;
  }

  Future<String> getAccessToken({bool getNew = false}) async {
    if (!getNew && _accessToken != null) return _accessToken;

    String refreshToken = await storage.read(key: 'refresh_token');

    Response res = await client.post(baseUrl + '/token',
        body: json.encode({'refresh_token': refreshToken}), headers: headers);

    if (res.statusCode != 200) {
      throw UnauthorizedError();
    }

    return _accessToken = json.decode(res.body)['access_token'];
  }

  Future<UserModel> getCurrentUser({bool getNew = false}) async {
    if (!getNew && _currentUser != null) return _currentUser;

    Response res = await client.get(baseUrl + 'url',
        headers: headers
          ..['Authentication'] = 'Bearer ' + await getAccessToken());

    if (res.statusCode != 200) {
      throw UnauthorizedError();
    }

    return _currentUser = UserModel.fromJson(json.decode(res.body));
  }
}

class UnauthorizedError extends Error {}
