import 'package:ar_flutter/modules/edit_session/controllers/edit_session_controller.dart';
import 'package:get/get.dart';

class EditSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EditSessionController>(EditSessionController());
  }

}