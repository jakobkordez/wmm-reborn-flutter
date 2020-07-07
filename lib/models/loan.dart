class LoanModel {
  int _id;
  String _sender;
  String _reciever;
  String _creator;
  double _amount;
  DateTime _created;
  DateTime _confirmed;

  LoanModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _sender = parsedJson['sender'];
    _reciever = parsedJson['reciever'];
    _creator = parsedJson['creator'];
    _amount = parsedJson['amount'];
    _created = DateTime.parse(parsedJson['created']);
    _confirmed = DateTime.parse(parsedJson['confirmed']);
  }

  int get id => _id;
  String get sender => _sender;
  String get reciever => _reciever;
  String get creator => _creator;
  double get amount => _amount;
  DateTime get created => _created;
  DateTime get confirmed => _confirmed;
}
