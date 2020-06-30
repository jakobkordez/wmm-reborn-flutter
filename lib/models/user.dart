class UserModel {
  String _username;
  String _name;
  double _totalLent;
  double _totalBorrowed;
  double _currentLent;
  double _currentBorrowed;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _username = parsedJson['username'];
    _name = parsedJson['name'];
    _totalLent = parsedJson['total_lent'];
    _totalBorrowed = parsedJson['total_borrowed'];
    _currentLent = parsedJson['current_lent'];
    _currentBorrowed = parsedJson['current_borrowed'];
  }

  String get username => _username;
  String get name => _name;
  double get totalLent => _totalLent;
  double get totalBorrowed => _totalBorrowed;
  double get currentLent => _currentLent;
  double get currentBorrowed => _currentBorrowed;
}