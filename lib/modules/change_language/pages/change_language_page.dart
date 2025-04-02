import 'package:ar_flutter/modules/change_language/controllers/change_language_controller.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends GetView<ChangeLanguageController> {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('language'.tr),
            backgroundColor: AppColors.primaryBlue,
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios))),
        body: Obx(
          () => Column(
            children: <Widget>[
              RadioListTile<int>(
                title: Text('english'.tr),
                value: Languages.english,
                groupValue: controller.selectLanguage.value,
                activeColor: AppColors.primaryBlue,
                onChanged: (int? value) {
                  if (value == null) {
                    return;
                  }
                  controller.setSelectedLanguage(value);
                  controller.saveLanguage();
                },
              ),
              RadioListTile<int>(
                title: Text('vietnamese'.tr),
                value: Languages.vietnamese,
                groupValue: controller.selectLanguage.value,
                activeColor: AppColors.primaryBlue,
                onChanged: (int? value) {
                  if (value == null) {
                    return;
                  }
                  controller.setSelectedLanguage(value);
                  controller.saveLanguage();
                },
              ),
            ],
          ),
        ));
  }
}
