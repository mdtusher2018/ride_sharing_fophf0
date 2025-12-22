import 'package:get/get.dart';
import 'package:velozaje/localization/english.dart';
import 'package:velozaje/localization/spanish.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'en_ES': en_ES};
}
