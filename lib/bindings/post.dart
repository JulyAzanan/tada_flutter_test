import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';
import 'package:tada_flutter_test/controllers/post.dart';

class PostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Api());
    Get.lazyPut(() => PostController(), fenix: true);
  }
}
