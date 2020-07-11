class LoanModel {
  int _id;
  String _sender;
  String _reciever;
  String _creator;
  double _amount;
  DateTime _created;
  int _status;
  DateTime _modified;

  LoanModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _sender = parsedJson['sender'];
    _reciever = parsedJson['reciever'];
    _creator = parsedJson['creator'];
    _amount = parsedJson['amount'].toDouble();
    _created = DateTime.tryParse(parsedJson['created']);
    _status = parsedJson['status'];
    _modified = DateTime.tryParse(parsedJson['modified'] ?? '');
  }

  LoanModel();

  int get id => _id;
  String get sender => _sender;
  String get reciever => _reciever;
  String get creator => _creator;
  double get amount => _amount;
  DateTime get created => _created;
  int get status => _status;
  DateTime get modified => _modified;
}
