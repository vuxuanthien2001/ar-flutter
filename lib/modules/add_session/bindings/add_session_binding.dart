import 'package:ar_flutter/modules/add_session/controllers/add_session_controller.dart';
import 'package:get/get.dart';

class AddSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddSessionController>(AddSessionController());
  }
}