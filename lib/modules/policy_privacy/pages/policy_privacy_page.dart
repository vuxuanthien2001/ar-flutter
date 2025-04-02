import 'package:ar_flutter/modules/policy_privacy/controllers/policy_privacy_controller.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPrivacyPage extends GetView<PolicyPrivacyController> {
  const PolicyPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('policy_privacy'.tr),
            backgroundColor: AppColors.primaryBlue,
            leading: GestureDetector(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back_ios))),
        body: WebViewWidget(controller: controller.webViewController));
  }
}
