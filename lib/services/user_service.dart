import 'package:http/http.dart' show Client, Response;
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final Client client;

  UserService(this.client);

  Future<bool> authenticate({@required String username, @required String password}) async {
    // TODO: Implement authenticate
    throw UnimplementedError();
  }
}