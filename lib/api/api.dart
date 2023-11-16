import 'dart:convert';

import 'package:get/get.dart';
import 'package:tada_flutter_test/models/comments.dart';
import 'package:tada_flutter_test/models/posts.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/utils/constants.dart';

class Api extends GetConnect {
  Future<Response<List<User>>> getUsers() async {
    return await get(
      "$apiBaseUrl/users",
      decoder: User.listDecoder,
    );
  }

  Future<Response<List<Comment>>> getComments() async {
    return await get(
      "$apiBaseUrl/comments",
      decoder: Comment.listDecoder,
    );
  }

  Future<Response<List<Post>>> getPosts() async {
    return await get(
      "$apiBaseUrl/posts",
      decoder: Post.listDecoder,
    );
  }

  Future<Response<bool>> deletePost(int id) async {
    return await delete("$apiBaseUrl/posts/$id", decoder: (_) => true);
  }

  Future<Response<Post>> addPost(String title, String body, int userId) async {
    return await post(
      "$apiBaseUrl/posts",
      jsonEncode(
        {
          "title": title,
          "body": body,
          "userId": userId,
        },
      ),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      decoder: (json) => Post.decoder(json),
    );
  }
}
