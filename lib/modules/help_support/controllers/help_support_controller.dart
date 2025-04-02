import 'package:ar_flutter/languages/language_service.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:ar_flutter/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  Rx<int> selectLanguage = Languages.english.obs;
  AuthService authService = Get.find<AuthService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController questionController = TextEditingController();

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

  sendQuestion() {
    if (emailController.text.isEmpty || !emailController.text.isEmail) {
      Helper.showSnackBar("help_support".tr, "email_warning".tr);
      return;
    }

    if (questionController.text.isEmpty) {
      Helper.showSnackBar("help_support".tr, "question_warning".tr);
      return;
    }

    Get.back();
    Helper.showSnackBar("help_support".tr, "send_question_success".tr);
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
  }
}
