import 'package:ar_flutter/modules/project_blueprint/controllers/project_blueprint_controller.dart';
import 'package:get/get.dart';

class ProjectBlueprintBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProjectBlueprintController>(ProjectBlueprintController());
  }

}