import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';
import 'package:tada_flutter_test/bindings/initial.dart';
import 'package:tada_flutter_test/i18n/translations.dart';
import 'package:tada_flutter_test/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut(() => Api());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Post Visualizer 3615',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 148, 183)),
        useMaterial3: true,
      ),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.home,
      initialBinding: InitialBindings(),
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale("fr", "FR"),
    );
  }
}
