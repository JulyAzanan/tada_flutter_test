import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';
import 'package:tada_flutter_test/models/posts.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/utils/handler.dart';
import 'package:tada_flutter_test/utils/options.dart';

class HomeService {
  static Future<bool> getPosts(Rx<Options<List<Post>>> Function() posts) async {
    Api api = Get.find();
    return await Handler.apiCallHandler(
      apiMethod: () async => await api.getPosts(),
      accessor: posts,
    );
  }

  static Future<bool> getUsers(Rx<Options<List<User>>> Function() users) async {
    Api api = Get.find();
    return await Handler.apiCallHandler(
      apiMethod: () async => await api.getUsers(),
      accessor: users,
    );
  }

  static Future<bool> deletePost(int id, Future<void> Function(bool) onSuccess,
      Future<void> Function(Exception) onFailure) async {
    Api api = Get.find();
    return await Handler.apiCallHandler(
      apiMethod: () async => await api.deletePost(id),
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
  }
}
