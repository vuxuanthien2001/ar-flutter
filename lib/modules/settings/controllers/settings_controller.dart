import 'package:ar_flutter/routes/app_pages.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var optionSettingApplication =
      ["language".tr, "help_support".tr, "policy_privacy".tr].obs;

  resetTextOptionSettingWhenChangeLang() {
    optionSettingApplication.clear();
    optionSettingApplication.value = [
      "language".tr,
      "help_support".tr,
      "policy_privacy".tr
    ];
  }

  void onTapOptionSetting(int optionIndex) {
    if (optionIndex == 0) {
      Get.toNamed(Routes.CHANGE_LANGUAGE);
    } else if (optionIndex == 1) {
      Get.toNamed(Routes.HELP_SUPPORT);
    } else if (optionIndex == 2) {
      Get.toNamed(Routes.POLICY_PRIVACY);
    }
  }
}
