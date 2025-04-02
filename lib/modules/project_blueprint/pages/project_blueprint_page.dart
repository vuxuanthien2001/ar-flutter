import 'package:ar_flutter/modules/project_blueprint/controllers/project_blueprint_controller.dart';
import 'package:ar_flutter/modules/project_blueprint/models/session_state_model.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProjectBlueprintPage extends GetView<ProjectBlueprintController> {
  const ProjectBlueprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            SizedBox(
                width: Get.width,
                height: Get.height,
                child:
                    (controller.currentStatus.value == ARSessionStatus.initial)
                        ? (controller.isCameraInitialize.value)
                            ? CameraPreview(controller.cameraController.value)
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                        : ARKitSceneView(
                            onARKitViewCreated: controller.onARKitViewCreated,
                            showWorldOrigin: false,
                          )),
            Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: Colors.black12)
                        ]),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 30,
                          ),
                          Text(
                            "exit_ar".tr,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )),
              ),
            ),
            (controller.isCameraInitialize.value)
                ? Positioned.fill(
                    child: Align(
                    alignment: Alignment.center,
                    child: instructionWidget(),
                  ))
                : const SizedBox()
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            print(
                "------- CURRENT STATUS: ${controller.currentStatus.value.name}");
            switch (controller.currentStatus.value) {
              case ARSessionStatus.initial:
                controller.currentStatus.value = ARSessionStatus.planeSelected;
                controller.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  controller.needInstructionVisible.value = false;
                });
              case ARSessionStatus.planeSelected:
                controller.createSelectedPoint();
                controller.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  controller.needInstructionVisible.value = false;
                });
              case ARSessionStatus.bottomPointsSelected:
                controller.currentStatus.value = ARSessionStatus.heightSelected;
                controller.updateNodeWhenMesureHeight();
                controller.arkitController.value
                    ?.remove(controller.movingNode.value!.name);
                controller.createTopPoints();
                controller.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  controller.needInstructionVisible.value = false;
                });
              case ARSessionStatus.heightSelected:
                controller.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  controller.needInstructionVisible.value = false;
                });
              default:
                print("------- CURRENT STATUS: ERROR");
            }
          },
          child:
              (controller.currentStatus.value != ARSessionStatus.heightSelected)
                  ? Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primaryBlue),
                      child: Icon(
                        Icons.my_location_rounded,
                        size: 30,
                        color: AppColors.primaryGrey,
                      ))
                  : const SizedBox(),
        ),
      ),
    );
  }

  Widget instructionWidget() {
    SessionStateModel currentSessionState;
    switch (controller.currentStatus.value) {
      case ARSessionStatus.initial:
        currentSessionState = sessionStates[0];
        break;
      case ARSessionStatus.planeSelected:
        currentSessionState = sessionStates[1];
        break;
      case ARSessionStatus.bottomPointsSelected:
        currentSessionState = sessionStates[2];
        break;
      case ARSessionStatus.heightSelected:
        currentSessionState = sessionStates[3];
        break;
      default:
        currentSessionState = sessionStates[0];
        break;
    }

    return Visibility(
      visible: controller.needInstructionVisible.value,
      child: Container(
        width: Get.width * 0.5,
        height: Get.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              currentSessionState.imagePath,
              color: (currentSessionState.id == 3)
                  ? AppColors.primaryGreen
                  : AppColors.primaryGrey,
              height: Get.width * 0.25,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  currentSessionState.text,
                  style: TextStyle(
                      color: (currentSessionState.id == 3)
                          ? AppColors.primaryGreen
                          : AppColors.primaryGrey,
                      fontWeight: (currentSessionState.id == 3)
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
