import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:wmm_reborn_flutter/models/user.dart';
import 'package:wmm_reborn_flutter/repositories/base_repository.dart';
import 'package:wmm_reborn_flutter/repositories/user_repository.dart';

class FriendRepository {
  FriendRepository(this.baseRepository, this.userRepository);
  
  final BaseRepository baseRepository;
  final UserRepository userRepository;

  String get baseUrl => '/friends';

  Future<List<UserModel>> getFriends() async {
    Response res = await baseRepository.send('GET', baseUrl);

    if (res.statusCode != 200) throw Error();

    final lList = json.decode(res.body) as List<dynamic>;

    return await Future.wait<UserModel>(lList.map((e) => userRepository.getUser(username: e)));
  }
}