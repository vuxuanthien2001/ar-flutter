import 'dart:io';

import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  RxList<dynamic> savedSessions = <dynamic>[].obs;

  RxString localDirectory = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    refreshSavedSessions();

    localDirectory.value = (GetPlatform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory())!
        .path;
  }

  List<dynamic> getSavedSessions() {
    var result = authService.listSessions;

    if (result == null) {
      return [];
    }
    return result;
  }

  refreshSavedSessions() {
    savedSessions.clear();
    savedSessions.addAll(getSavedSessions());
  }

  void startARSession(int index) {
    SessionModel currentSession = savedSessions[index];
    Get.toNamed(
      Routes.PROJECT_BLUEPRINT,
      // Routes.PLANE_DETECTION,
      arguments: {
        'scale': currentSession.scalingRatio.toString(),
        'file': File(localDirectory + "/" + currentSession.imagePath),
      },
    );
  }
}
