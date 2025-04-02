import 'package:ar_flutter/modules/help_support/controllers/help_support_controller.dart';
import 'package:get/get.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HelpSupportController>(HelpSupportController());
  }
}