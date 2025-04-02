import 'package:ar_flutter/languages/language_service.dart';
import 'package:ar_flutter/main_navigate_page.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:ar_flutter/utils/numeral.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  AuthService authService = Get.find<AuthService>();
  final Duration animationDuration =
      Duration(milliseconds: Numeral.DURATION_ANIM_FADEIN_LAUNCH);
  final Duration reverseDuration =
      Duration(milliseconds: Numeral.DURATION_ANIM_FADEOUT_LAUNCH);

  late AnimationController animLogoController;
  late Animation<double> animationLogo;
  late AnimationController animBackgroundController;
  late Animation<double> animationBackground;

  @override
  Future<void> onInit() async {
    super.onInit();
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
    await startAnimation();
  }

  Future<void> startAnimation() async {
    animBackgroundController = AnimationController(
        duration: animationDuration,
        reverseDuration: reverseDuration,
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    animLogoController = AnimationController(
        duration: animationDuration,
        reverseDuration: reverseDuration,
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    animationBackground = CurvedAnimation(
        parent: animBackgroundController, curve: Curves.fastOutSlowIn);
    animationLogo = CurvedAnimation(
        parent: animLogoController, curve: Curves.fastOutSlowIn);
    animBackgroundController.forward();
    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => animLogoController.forward().then((value) async => {
              await animLogoController.reverse(),
              animBackgroundController
                  .reverse()
                  .then((value) => Get.offAllNamed(Routes.MAIN_NAVIGATE))
            }));
  }

  @override
  dispose() {
    animBackgroundController.dispose();
    animLogoController.dispose();
    super.dispose();
  }
}
