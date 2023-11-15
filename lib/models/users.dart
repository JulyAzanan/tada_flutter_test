import 'dart:convert';

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  /// [json] must be like
  /// ```json
  /// {
  ///   "id": <int>,
  ///   "name": <String>,
  ///   "username": <String>,
  ///   "email": <String>,
  ///   ...
  /// }
  /// ```
  static User decoder(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      username: json["username"],
      name: json["name"],
    );
  }

  /// [json] must be like
  /// ```json
  /// [
  ///   {<User>},
  ///   {<User>},
  ///   {<User>},
  ///   ...
  /// ]
  /// ```
  static List<User> listDecoder(dynamic json) {
    final users = json as List;

    return users.map((jsonUser) => decoder(jsonUser)).toList();
  }

  String toJson() {
    return jsonEncode({
      "id": id,
      "name": name,
      "username": username,
      "email": email,
    });
  }
}
