import 'package:ar_flutter/modules/add_session/controllers/add_session_controller.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/widgets/base_auto_size_text.dart';
import 'package:ar_flutter/widgets/base_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSessionPage extends GetView<AddSessionController> {
  const AddSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryGrey,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.hardGrey,
            ),
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: Column(
              children: [
                titleWidget(),
                const SizedBox(height: 20),
                inputWidget(
                    title: "title".tr,
                    description: "name_of_the_project".tr,
                    hint: "project_title".tr,
                    controller: controller.inputNameController,
                    inputType: TextInputType.text),
                const SizedBox(height: 30),
                inputWidget(
                    title: "scaling_ratio".tr,
                    description: "ratio_between_drawing_actual_size".tr,
                    hint: "ratio".tr,
                    controller: controller.inputScaleController,
                    inputType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true)),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    var newImage = await controller.uploadImage();
                    if (newImage != null) {
                      controller.fileSelect.value = newImage;
                    }
                  },
                  child: imageWidget(
                      title: "image".tr,
                      description: "drawing_projected_onto_AR_environment".tr),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.saveSettings(isStartAR: false);
                      },
                      child: Container(
                        width: Get.width * 0.38,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.primaryBlue, width: 1.5)),
                        child: Center(
                          child: Text(
                            "save".tr,
                            style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.startAR();
                      },
                      child: Container(
                        width: Get.width * 0.38,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: AppColors.primaryBlue,
                        ),
                        child: Center(
                            child: Text(
                          "start_ar".tr,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  titleWidget() {
    return Column(
      children: [
        BaseAutoSizeText(
          width: Get.width * 0.4,
          height: Get.height * 0.05,
          text: "add_session".tr,
          textColor: AppColors.primaryBlue,
          fontWeight: FontWeight.w600,
        ),
        BaseAutoSizeText(
          width: Get.width * 0.7,
          height: Get.height * 0.04,
          text: "notification_add_session".tr,
          textColor: AppColors.primaryBlue,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        )
      ],
    );
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
        Container(
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
      ],
    );
  }

  imageWidget({required String title, required String description}) {
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
        Container(
            height: Get.width * 0.6,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7, color: Colors.black12, spreadRadius: 1)
                ]),
            child: (controller.fileSelect.value != null)
                ? Image.file(controller.fileSelect.value!)
                : Center(
                    child: Text("choose_image".tr,
                        style: TextStyle(
                            color: AppColors.lightGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center)))
      ],
    );
  }
}
