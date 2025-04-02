import 'package:ar_flutter/modules/settings/controllers/settings_controller.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/widgets/base_auto_size_text.dart';
import 'package:ar_flutter/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text('settings'.tr,
            style: TextStyle(
                color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.15,
              width: Get.width,
              margin: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/img_background_greeting.png"),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseAutoSizeText(
                          width: Get.width * 0.225,
                          height: Get.height * 0.04,
                          text: "hey_there".tr,
                          textColor: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                        BaseAutoSizeText(
                          width: Get.width * 0.5,
                          height: Get.height * 0.04,
                          text: "have_a_good_day".tr,
                          textColor: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/img_user.png",
                      height: Get.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Container(
                width: Get.width,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.hardGrey.withOpacity(0.2),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                    ),
                  ],
                ),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.optionSettingApplication.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.onTapOptionSetting(index),
                      child: ListTile(
                        title: BaseText(
                            text: controller.optionSettingApplication[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColors.lightGrey.withOpacity(0.5),
                      height: 1.5,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
