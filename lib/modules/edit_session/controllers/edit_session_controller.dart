import 'dart:io';
import 'package:ar_flutter/modules/home/controllers/home_controller.dart';
import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class EditSessionController extends GetxController {
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputScaleController = TextEditingController();
  final fileSelect = Rxn<File?>();
  Map arguments = {};

  AuthService authService = Get.find<AuthService>();
  Rx<SessionModel> currentSession = SessionModel(
    id: "-1",
    title: "",
    scalingRatio: 0.0,
    imagePath: "",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;
  RxString localDirectory = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    localDirectory.value = (GetPlatform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory())!
        .path;

    currentSession.value = Get.arguments;
    if (currentSession.value.id != "-1") {
      inputNameController.text = currentSession.value.title;
      inputScaleController.text = currentSession.value.scalingRatio.toString();
      fileSelect.value = File(localDirectory + "/" + currentSession.value.imagePath);
    }
  }

  saveSettings() async {
    if (inputNameController.text.isEmpty) {
      Helper.showSnackBar("error".tr, "please_enter_the_session_name".tr);
      return;
    }

    if (inputScaleController.text.isEmpty) {
      Helper.showSnackBar("error".tr, "please_enter_scaling_ratio".tr);
      return;
    }

    if (fileSelect.value == null) {
      Helper.showSnackBar("error".tr, "please_select_an_image".tr);
      return;
    }
    // Save session to local
    DateTime now = DateTime.now().toUtc();

    String? newFilePath;
    if (Path.basename(fileSelect.value!.path) == currentSession.value.imagePath) {
      newFilePath = currentSession.value.imagePath;
    } else {
      newFilePath = await Helper.saveFileToLocal(file: fileSelect.value!, time: now);
    }
    currentSession.value = SessionModel(
        id: currentSession.value.id,
        title: inputNameController.text,
        scalingRatio: double.parse(inputScaleController.text),
        imagePath: newFilePath,
        createdAt: currentSession.value.createdAt,
        updatedAt: now);
    authService.editSessions(currentSession.value);
    Get.find<HomeController>().refreshSavedSessions();
    Get.back();
    Helper.showSnackBar("app_name".tr, "save_done".tr);
  }

  void uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file =
        File("${localDirectory.value}/${currentSession.value.imagePath}");
      file.delete();
      fileSelect.value = File(pickedFile.path);
    }
  }
}
