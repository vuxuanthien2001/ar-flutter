import 'package:ar_flutter/modules/splash/controllers/splash_controller.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/widgets/base_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: controller.animationBackground,
        child: GestureDetector(
          onTap: () async {
            await controller.animLogoController.reverse();
            controller.animBackgroundController
                .reverse()
                .then((value) => Get.offAllNamed(Routes.MAIN_NAVIGATE));
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(color: AppColors.colorBackgroundSplash),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: controller.animationLogo,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/icons/logo_app.jpg",
                          height: Get.width * 0.5,
                          width: Get.width * 0.5,
                        ),
                        BaseAutoSizeText(
                          width: Get.width * 0.45,
                          height: Get.height * 0.04,
                          text: "app_name".tr,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.colorTextSplash,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
