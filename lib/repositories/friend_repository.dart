import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/base_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

class FriendRepository {
  FriendRepository(this.baseRepository, this.userRepository);

  final BaseRepository baseRepository;
  final UserRepository userRepository;

  String get basePath => '/friends';

  Future<List<UserModel>> getFriends() async {
    Response res = await baseRepository.send('GET', basePath);

    if (res.statusCode != 200) throw Error();

    final lList = json.decode(res.body) as List<dynamic>;

    return await Future.wait<UserModel>(
        lList.map((e) => userRepository.getUser(username: e)));
  }

  Future<List<UserModel>> getRequests() async {
    Response res = await baseRepository.send('GET', '$basePath/requests');

    if (res.statusCode != 200) throw Error();

    final rList = json.decode(res.body) as List<dynamic>;

    return await Future.wait<UserModel>(
        rList.map((e) => userRepository.getUser(username: e)));
  }

  Future<void> addFriend(String username) async {
    Response res = await baseRepository.send('GET', '$basePath/add/$username');

    if (res.statusCode != 200) throw Error();
  }

  Future<void> removeFriend(String username) async {
    Response res =
        await baseRepository.send('GET', '$basePath/remove/$username');

    if (res.statusCode != 200) throw Error();
  }
}
