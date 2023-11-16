import 'package:get/get.dart';
import 'package:tada_flutter_test/bindings/home.dart';
import 'package:tada_flutter_test/bindings/post.dart';
import 'package:tada_flutter_test/pages/home.dart';
import 'package:tada_flutter_test/pages/post.dart';

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
    GetPage(
      name: post,
      page: () => PostPage(),
      bindings: [
        PostBindings(),
      ],
    ),
  ];
}
