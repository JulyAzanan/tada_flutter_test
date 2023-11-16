import 'package:get/get.dart';
import 'package:tada_flutter_test/i18n/en_US.dart';
import 'package:tada_flutter_test/i18n/fr_FR.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fr_FR': frFR,
      };
}
