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

  final TextEditingController textController = TextEditingController(text: "");
  final searchText = "".obs;

  Locale locale = Get.deviceLocale ?? const Locale("fr", "FR");

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
          "delete_success".tr,
          "delete_success_body".tr,
          backgroundColor: Colors.greenAccent,
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.check),
        );
        posts.value.getValue().removeWhere(
            (post) => post.id == id); // posts is SOME if this is called
        posts.refresh();
      },
      (e) async {
        Get.snackbar(
          "delete_error".tr,
          "delete_error_body".tr,
          backgroundColor: Colors.redAccent,
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error),
        );
      },
    );
  }

  Future<void> addPost() async {
    await HomeService.addPost("new_title".tr, "new_body".tr, 1, (post) async {
      Get.snackbar(
        "add_success".tr,
        "add_success_body".tr,
        backgroundColor: Colors.greenAccent,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.check),
      );
      posts.value.getValue().add(post); // posts is SOME if this is called
      posts.refresh();
    }, (e) async {
      Get.snackbar(
        "add_error".tr,
        "add_error_body".tr,
        backgroundColor: Colors.redAccent,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error),
      );
    });
  }

  List<Post> filterPost(
    List<Post> unfilteredPosts,
    List<User> unfilteredUsers,
    String searchText,
  ) {
    final filteredUsers = unfilteredUsers.where(
        (user) => user.name.toLowerCase().contains(searchText.toLowerCase()));

    return unfilteredPosts
        .where((post) =>
            post.title.toLowerCase().contains(searchText.toLowerCase()) ||
            filteredUsers.any((user) => user.id == post.userId))
        .toList();
  }
}
