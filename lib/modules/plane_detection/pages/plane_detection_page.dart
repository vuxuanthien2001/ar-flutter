import 'package:ar_flutter/modules/plane_detection/controllers/plane_detection_controller.dart';
import 'package:ar_flutter/modules/project_blueprint/models/session_state_model.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PlaneDetectionPage extends StatefulWidget {
  @override
  _PlaneDetectionPageState createState() => _PlaneDetectionPageState();
}

class _PlaneDetectionPageState extends State<PlaneDetectionPage> {
  PlaneDetectionController planeDetectionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            SizedBox(
                width: Get.width,
                height: Get.height,
                child: (planeDetectionController.currentStatus.value ==
                        ARSessionStatus.initial)
                    ? (planeDetectionController.isCameraInitialize.value)
                        ? CameraPreview(
                            planeDetectionController.cameraController.value)
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blue,
                          ))
                    : ARKitSceneView(
                        // planeDetection: (planeDetectionController.orientationVertical.value) ? ARPlaneDetection.none : ARPlaneDetection.horizontal,
                        // enableTapRecognizer: true,
                        onARKitViewCreated:
                            planeDetectionController.onARKitViewCreated,
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
            (planeDetectionController.isCameraInitialize.value)
                ? Positioned.fill(
                    child: Align(
                    alignment: Alignment.center,
                    child: instructionWidget(),
                  ))
                : const SizedBox(),
            (planeDetectionController.currentStatus.value ==
                    ARSessionStatus.initial)
                ? Positioned(
                    top: 30,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        planeDetectionController.orientationVertical.toggle();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1.5)
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: SvgPicture.asset(
                              planeDetectionController.orientationVertical.value
                                  ? "assets/icons/ic_horizontal.svg"
                                  : "assets/icons/ic_vertical.svg"),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            print(
                "------- CURRENT STATUS: ${planeDetectionController.currentStatus.value.name}");
            switch (planeDetectionController.currentStatus.value) {
              case ARSessionStatus.initial:
                planeDetectionController.currentStatus.value =
                    ARSessionStatus.planeSelected;
                planeDetectionController.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  planeDetectionController.needInstructionVisible.value = false;
                });
              case ARSessionStatus.planeSelected:
                planeDetectionController.createSelectedPoint();
                planeDetectionController.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  planeDetectionController.needInstructionVisible.value = false;
                });
              case ARSessionStatus.bottomPointsSelected:
                planeDetectionController.currentStatus.value =
                    ARSessionStatus.heightSelected;
                planeDetectionController.updateNodeWhenMesureHeight();
                planeDetectionController.arkitController.value
                    ?.remove(planeDetectionController.movingNode.value!.name);
                //planeDetectionController.createTopPoints();
                planeDetectionController.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  planeDetectionController.needInstructionVisible.value = false;
                });
              case ARSessionStatus.heightSelected:
                planeDetectionController.needInstructionVisible.value = true;
                Future.delayed(const Duration(seconds: 5), () {
                  planeDetectionController.needInstructionVisible.value = false;
                });
              default:
                print("------- CURRENT STATUS: ERROR");
            }
          },
          child: (planeDetectionController.currentStatus.value !=
                  ARSessionStatus.heightSelected)
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
    switch (planeDetectionController.currentStatus.value) {
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
      visible: planeDetectionController.needInstructionVisible.value,
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
