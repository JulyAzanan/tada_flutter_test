import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  static Post decoder(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  static List<Post> listDecoder(dynamic json) {
    final posts = json as List;

    return posts.map((jsonPost) => decoder(jsonPost)).toList();
  }

  String toJson() {
    return jsonEncode({
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    });
  }
}
