import 'package:ar_flutter/modules/help_support/controllers/help_support_controller.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/widgets/base_text.dart';
import 'package:ar_flutter/widgets/base_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpSupportPage extends GetView<HelpSupportController> {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('help_support'.tr),
            backgroundColor: AppColors.primaryBlue,
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios))),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: SvgPicture.asset(
                  "assets/icons/ic_question_support.svg",
                  width: 35,
                  color: AppColors.primaryBlue,
                )),
                const SizedBox(height: 10),
                BaseText(
                  text: "help_support_title".tr,
                  size: 25,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                BaseText(
                  text:
                      "help_support_desc".tr,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.lightGrey,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      inputWidget(
                          title: "email".tr,
                          description: "email_description".tr,
                          hint: "email".tr,
                          controller: controller.emailController,
                          inputType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      inputWidget(
                          title: "question".tr,
                          description: "question_description".tr,
                          hint: "question".tr,
                          controller: controller.questionController,
                          inputType: TextInputType.text),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => controller.sendQuestion(),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: BaseText(
                      text: "send_question_button".tr,
                      fontWeight: FontWeight.w500,
                      size: 16,
                      textColor: Colors.white,
                    )),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  inputWidget({
    required String title,
    required String description,
    required String hint,
    required TextEditingController controller,
    required TextInputType? inputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.hardGrey,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: TextStyle(
              color: AppColors.hardGrey,
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
        const SizedBox(height: 10),
        (title != "question".tr)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, color: Colors.black12, spreadRadius: 1)
                    ]),
                child: BaseTextFormField(
                  hint: hint,
                  textInputType: inputType,
                  controller: controller,
                ))
            : Container(
                height: Get.height * 0.2,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, color: Colors.black12, spreadRadius: 1)
                    ]),
                child: TextField(
                  maxLength: 500,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      hintText: "question".tr),
                ),
              )
      ],
    );
  }
}
