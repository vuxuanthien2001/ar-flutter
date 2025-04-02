import 'dart:io';
import 'package:ar_flutter/modules/home/controllers/home_controller.dart';
import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddSessionController extends GetxController {
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputScaleController = TextEditingController();
  final fileSelect = Rxn<File?>();
  Map arguments = {};

  AuthService authService = Get.find<AuthService>();

  saveSettings({required bool isStartAR}) async {
    if (inputNameController.text.isEmpty) {
      Helper.showSnackBar("error".tr, "please_enter_the_session_name".tr);
      return;
    }

    if (inputScaleController.text.isEmpty) {
      Helper.showSnackBar("error".tr, "please_enter_scaling_ratio".tr);
      return;
    }

    double? scaleRatio = double.tryParse(inputScaleController.text);
    if (scaleRatio == null) {
      Helper.showSnackBar("error".tr, "please_enter_scaling_ratio".tr);
      return;
    }

    if (fileSelect.value == null) {
      Helper.showSnackBar("error".tr, "please_select_an_image".tr);
      return;
    }

    // Save session to local
    DateTime now = DateTime.now().toUtc();

    String newFilePath =
        await Helper.saveFileToLocal(file: fileSelect.value!, time: now);

    print("------------ New Session ID: ${now.toIso8601String()}");
    print("------------ New Session PATH: ${newFilePath}");

    SessionModel currentSession = SessionModel(
        id: now.toIso8601String(),
        title: inputNameController.text,
        scalingRatio: scaleRatio,
        imagePath: newFilePath,
        createdAt: now,
        updatedAt: now);

    authService.addSession(currentSession);
    Get.find<HomeController>().refreshSavedSessions();

    if (!isStartAR) {
      Get.back();
      Helper.showSnackBar("app_name".tr, "save_done".tr);
    } else {
      Get.offAndToNamed(
        Routes.PROJECT_BLUEPRINT,
        arguments: {
          'scale': inputScaleController.text,
          'file': fileSelect.value,
        },
      );
    }
  }

  startAR() async {
    saveSettings(isStartAR: true);
  }

  Future<File?> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
