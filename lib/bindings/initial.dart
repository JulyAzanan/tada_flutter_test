import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Api());
  }
}