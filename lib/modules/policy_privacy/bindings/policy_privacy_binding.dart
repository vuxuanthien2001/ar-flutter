import 'package:ar_flutter/modules/policy_privacy/controllers/policy_privacy_controller.dart';
import 'package:get/get.dart';

class PolicyPrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PolicyPrivacyController>(PolicyPrivacyController());
  }
}