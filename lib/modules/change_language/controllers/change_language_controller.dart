import 'package:ar_flutter/languages/language_service.dart';
import 'package:ar_flutter/modules/settings/controllers/settings_controller.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:get/get.dart';

class ChangeLanguageController extends GetxController {
  Rx<int> selectLanguage = Languages.english.obs;
  AuthService authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    switch (authService.languageApp) {
      case Languages.english:
        selectLanguage.value = Languages.english;
        break;
      case Languages.vietnamese:
        selectLanguage.value = Languages.vietnamese;
        break;
      default:
        selectLanguage.value = Languages.english;
        break;
    }
  }

  setSelectedLanguage(int value) {
    selectLanguage.value = value;
  }

  saveLanguage() {
    authService.setLanguageServiceApp(selectLanguage.value);
    switch (authService.languageApp) {
      case Languages.english:
        LanguageService.changeLocale("en");
        break;
      case Languages.vietnamese:
        LanguageService.changeLocale("vi");
        break;
      default:
        LanguageService.changeLocale("en");
        Get.find<AuthService>().setLanguageServiceApp(Languages.english);
        break;
    }
    Get.find<SettingsController>().resetTextOptionSettingWhenChangeLang();
  }
}
