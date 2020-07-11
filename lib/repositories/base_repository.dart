import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client, Response, Request;

class BaseRepository {
  static const String _baseUrl = 'https://wmm.jkob.cc/api';

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Client _client = Client();

  String _accessToken;

  Future<Response> send(
    String method,
    String path, {
    Map<String, Object> body,
    bool identify = true,
  }) async {
    Request req = Request(method, Uri.parse('$_baseUrl$path'));
    req.headers['Content-type'] = 'application/json';
    if (identify)
      req.headers['Authorization'] = 'Bearer ${await getAccessToken()}';

    if (body != null) req.body = json.encode(body);

    Response res = await Response.fromStream(await _client.send(req));

    if (!identify || res.statusCode != 401) return res;

    if (identify)
      req.headers['Authorization'] =
          'Bearer ${await getAccessToken(getNew: true)}';

    return Response.fromStream(await _client.send(req));
  }

  Future<String> getAccessToken({bool getNew = false}) async {
    if (!getNew && _accessToken != null) return _accessToken;

    String refreshToken = await getToken();

    Response res = await send('POST', '/users/token',
        body: {'refresh_token': refreshToken}, identify: false);

    if (res.statusCode != 200) {
      throw UnauthorizedError();
    }

    return _accessToken = json.decode(res.body)['access_token'];
  }

  Future<bool> hasToken() async {
    return await getToken() != null;
  }

  Future<String> getToken() {
    return _storage.read(key: 'refresh_token');
  }

  Future<void> persistToken(String token) {
    return _storage.write(key: 'refresh_token', value: token);
  }

  Future<void> deleteToken() {
    return _storage.delete(key: 'refresh_token');
  }
}

class UnauthorizedError extends Error {}
