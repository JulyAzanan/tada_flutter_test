import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/models/posts.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/services/home.dart';
import 'package:tada_flutter_test/utils/options.dart';

class HomeController extends GetxController {
  final Rx<Options<List<Post>>> posts = Rx(Options());
  final Rx<Options<List<User>>> users = Rx(
      Options()); // Fetching all of them to be able to sort on their name too !

  @override
  void onInit() {
    _getPosts();
    _getUsers();

    super.onInit();
  }

  Future<bool> _getPosts() async {
    return await HomeService.getPosts(() => posts);
  }

  Future<bool> _getUsers() async {
    return await HomeService.getUsers(() => users);
  }

  Future<void> deletePost(int id) async {
    await HomeService.deletePost(
      id,
      (_) async {
        Get.snackbar(
          "delete_success".tr, // TODO : i18n
          "delete_success_body".tr, // TODO : i18n
          backgroundColor: Colors.greenAccent,
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.check),
        ); 
        posts.value.getValue().removeWhere((post) => post.id == id); // posts is SOME if this is called
      },
      (e) async {
        print(e);
        Get.snackbar(
          "delete_error".tr, // TODO : i18n
          "delete_error_body".tr, // TODO : i18n
          backgroundColor: Colors.redAccent,
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error),
        ); 
      },
    );
  }
}
