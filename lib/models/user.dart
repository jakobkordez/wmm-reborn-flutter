class UserModel {
  final String username;
  final String name;
  final double totalLent;
  final double totalBorrowed;
  final double currentLent;
  final double currentBorrowed;

  const UserModel._({
    this.username,
    this.name,
    this.totalLent,
    this.totalBorrowed,
    this.currentLent,
    this.currentBorrowed,
  });

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : username = parsedJson['username'],
        name = parsedJson['name'],
        totalLent = parsedJson['total_lent'].toDouble(),
        totalBorrowed = parsedJson['total_borrowed'].toDouble(),
        currentLent = parsedJson['current_lent'].toDouble(),
        currentBorrowed = parsedJson['current_borrowed'].toDouble();

  static const UserModel empty = UserModel._();
}
