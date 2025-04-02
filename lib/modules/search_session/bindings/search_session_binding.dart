import 'package:ar_flutter/modules/search_session/controllers/search_session_controller.dart';
import 'package:get/get.dart';

class SearchSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchSessionController>(SearchSessionController());
  }

}