import 'package:get/get.dart';
import 'package:tada_flutter_test/models/comments.dart';
import 'package:tada_flutter_test/models/posts.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/services/post.dart';
import 'package:tada_flutter_test/utils/options.dart';

class PostController extends GetxController {
  late Post post;
  late User user;
  Rx<Options<List<Comment>>> comments = Rx(Options());

  @override
  void onInit() {
    if (Get.arguments["post"] == null) {
      throw ArgumentError.notNull("post");
    }
    post = Get.arguments["post"];

    if (Get.arguments["user"] == null) {
      throw ArgumentError.notNull("user");
    }
    user = Get.arguments["user"];

    _getComments();

    super.onInit();
  }

  Future<bool> _getComments() async {
    return await PostService.getCommentsOf(post.id, () => comments);
  }
}
