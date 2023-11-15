import 'package:get/get.dart';
import 'package:tada_flutter_test/bindings/home.dart';
import 'package:tada_flutter_test/pages/home.dart';

class AppRoutes {
  static String home = "/";

  static String post = "/post";

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      bindings: [
        HomeBindings(),
      ],
    ),
  ];
}
