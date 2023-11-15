import 'dart:convert';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  static Comment decoder(Map<String, dynamic> json) {
    return Comment(
      postId: json["postId"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
      body: json["body"],
    );
  }

  static List<Comment> listDecoder(dynamic json) {
    final comments = json as List;

    return comments.map((jsonComment) => decoder(jsonComment)).toList();
  }

  String toJson() {
    return jsonEncode({
      "postId": postId,
      "id": id,
      "name": name,
      "email": email,
      "body": body
    });
  }
}
