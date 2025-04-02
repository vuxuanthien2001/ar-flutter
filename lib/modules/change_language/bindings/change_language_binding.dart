import 'package:ar_flutter/modules/change_language/controllers/change_language_controller.dart';
import 'package:get/get.dart';

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangeLanguageController>(ChangeLanguageController());
  }
}