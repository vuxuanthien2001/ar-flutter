import 'dart:convert';

import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  /// Storage.
  GetStorage boxStorage = GetStorage();

  /// Constant.
  static const KEY_LANGUAGE = "KEY_LANGUAGE";
  static const KEY_LIST_SESSIONS = "KEY_LIST_SESSIONS";

  Future<AuthService> init() async {
    return this;
  }

  setLanguageServiceApp(int language) {
    boxStorage.write(KEY_LANGUAGE, language);
  }

  int? get languageApp {
    return boxStorage.read(KEY_LANGUAGE);
  }

  setListSessions(List<dynamic> listSessions) {
    List<Map<String, dynamic>> listSessionJson = [];
    for (var element in listSessions) {
      listSessionJson.add(element.toJson());
    }

    boxStorage.write(KEY_LIST_SESSIONS, jsonEncode(listSessionJson));
  }

  List<dynamic>? get listSessions {
    List<dynamic> listSession = [];
    var result = boxStorage.read(KEY_LIST_SESSIONS);

    if (result == null) {
      return null;
    }

    dynamic jsonData = jsonDecode(result);
    listSession = jsonData.map((session) {
      return SessionModel.fromJson(session);
    }).toList();

    return listSession;
  }

  clearAllSessions() {
    boxStorage.remove("KEY_LIST_SESSIONS");
  }

  deleteSessions(SessionModel needDeleteSession) {
    var result = listSessions;
    if (result == null) {
      return;
    } else {
      result.remove(result.firstWhere((e) => e.id == needDeleteSession.id));
      setListSessions(result);
    }
  }

  addSession(SessionModel newSession) {
    var result = listSessions;
    if (result == null) {
      setListSessions([newSession]);
    } else {
      result.add(newSession);
      setListSessions(result);
    }
  }

  editSessions(SessionModel needUpdateSession) {
    var result = listSessions;
    if (result == null) {
      return;
    } else {
      int index = result.indexWhere((item) => item.id == needUpdateSession.id);
      if (index == -1) {
        return;
      } else {
        result[index] = needUpdateSession;
        setListSessions(result);
      }
    }
  }
}
