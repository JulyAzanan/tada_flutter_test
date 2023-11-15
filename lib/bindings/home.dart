import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';
import 'package:tada_flutter_test/controllers/home.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Api());
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
