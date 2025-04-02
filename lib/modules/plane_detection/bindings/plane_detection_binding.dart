import 'package:ar_flutter/modules/plane_detection/controllers/plane_detection_controller.dart';
import 'package:get/get.dart';

class PlaneDetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PlaneDetectionController>(PlaneDetectionController());
  } 
}