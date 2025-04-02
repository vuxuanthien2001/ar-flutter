import 'dart:io';

import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class SearchSessionController extends GetxController {
  TextEditingController searchController = TextEditingController();

  AuthService authService = Get.find<AuthService>();
  List<dynamic> allSavedSessions = [];
  RxList<dynamic> searchedSessions = <dynamic>[].obs;

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

  searchSession() {
    searchedSessions.clear();
    if (searchController.text.isEmpty) {
      searchedSessions.addAll(allSavedSessions);
      return;
    }

    for (var session in allSavedSessions) {
      if (session.title
          .toString()
          .toUpperCase()
          .contains(searchController.text.toUpperCase())) {
        searchedSessions.add(session);
      }
    }
  }

  List<dynamic> getSavedSessions() {
    var result = authService.listSessions;

    if (result == null) {
      return [];
    }
    return result;
  }

  refreshSavedSessions() {
    allSavedSessions.clear();
    allSavedSessions.addAll(getSavedSessions());

    searchedSessions.clear();
    searchedSessions.addAll(allSavedSessions);
  }

  void startARSession(int index) {
    SessionModel currentSession = searchedSessions[index];
    Get.toNamed(
      Routes.PROJECT_BLUEPRINT,
      arguments: {
        'scale': currentSession.scalingRatio.toString(),
        'file': File(localDirectory + "/" + currentSession.imagePath),
      },
    );
  }
}
