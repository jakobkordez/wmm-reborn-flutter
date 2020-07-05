import 'package:http/http.dart' show Client;

abstract class BaseRepository {
  final Client client = Client();

  String _baseUrl = 'https://wmm.jkob.cc/api';
  Map<String, String> _headers = {'Content-type': 'application/json'};

  String get baseUrl => _baseUrl;
  Map<String, String> get headers => _headers;
}
