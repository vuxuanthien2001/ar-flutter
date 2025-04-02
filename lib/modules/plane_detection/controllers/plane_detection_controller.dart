import 'package:ar_flutter/main.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:ar_flutter/utils/helper.dart';
import 'package:ar_flutter/utils/math_helper.dart';
import 'package:ar_flutter/utils/numeral.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class PlaneDetectionController extends GetxController {
  final arkitController = Rxn<ARKitController>();
  final movingNode = Rxn<ARKitNode>();

  ARKitPlane? plane;
  ARKitNode? node;
  String? anchorId;

  RxBool busy = false.obs;

  RxList<vector.Vector3?> listSelectedPoints = <vector.Vector3?>[].obs;

  final selectedPlaneNode = Rxn<ARKitNode>();
  // late Rx<ARKitNode?> selectedPlaneNode;
  // bool saveSelectedPlane = false;

  Map arguments = {};
  var displayedImage;

  var planeAngle;
  Rx<double?> planeDirection = 0.0.obs;

  late Rx<ARKitSceneView> sceneView;

  Rx<CameraController> cameraController = CameraController(
          cameras![0], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.bgra8888, enableAudio: false)
      .obs;
  RxBool isCameraInitialize = false.obs;

  Rx<ARSessionStatus> currentStatus = ARSessionStatus.initial.obs;
  RxBool needInstructionVisible = true.obs;

  var orientationVertical = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getArguments();
    setCameraController();
  }

  setCameraController() async {
    await cameraController.value.initialize().then((value) {
      isCameraInitialize.value = true;
    }).catchError((Object e) {
      print("------ CAMERA ERROR");
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  _getArguments() async {
    arguments = Get.arguments;
    displayedImage =
        await decodeImageFromList(arguments["file"].readAsBytesSync());
  }

  void createSelectedPoint() {
    if (listSelectedPoints.length == 2) {
      return;
    }

    final position = vector.Vector3(movingNode.value!.position.x,
        movingNode.value!.position.y, movingNode.value!.position.z);
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.constant,
      diffuse: ARKitMaterialProperty.color(Colors.blue),
    );
    final sphere = ARKitSphere(
      radius: 0.01,
      materials: [material],
    );
    final node = ARKitNode(
      geometry: sphere,
      position: position,
    );
    arkitController.value?.add(node);
    if (listSelectedPoints.isNotEmpty) {
      final line = ARKitLine(
          fromVector: listSelectedPoints.last!,
          toVector: position,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.red),
            )
          ]);
      final lineNode = ARKitNode(geometry: line);
      arkitController.value?.add(lineNode);

      final distance =
          _calculateDistanceBetweenPoints(position, listSelectedPoints.last!);
      final point = _getMiddleVector(position, listSelectedPoints.last!);
      _drawText(distance, point);
    }

    listSelectedPoints.add(position);

    print(
        "----- CREATED POINT: ${listSelectedPoints.last?.x} : ${listSelectedPoints.last?.y} : ${listSelectedPoints.last?.z}");

    if (listSelectedPoints.length == 2) {
      _createSelectedPlane();
    }
  }

  _createSelectedPlane() {
    // Add top points to list
    final firstTopPoint = orientationVertical.value
        ? vector.Vector3(listSelectedPoints.last!.x,
            listSelectedPoints.last!.y + 0.2, listSelectedPoints.last!.z)
        : vector.Vector3(listSelectedPoints.last!.x, listSelectedPoints.last!.y,
            listSelectedPoints.last!.z - 0.2);
    final secondTopPoint = orientationVertical.value
        ? vector.Vector3(listSelectedPoints.first!.x,
            listSelectedPoints.first!.y + 0.2, listSelectedPoints.first!.z)
        : vector.Vector3(listSelectedPoints.first!.x,
            listSelectedPoints.first!.y, listSelectedPoints.first!.z - 0.2);

    listSelectedPoints.addAll([firstTopPoint, secondTopPoint]);

    // Draw selected plane
    final width = listSelectedPoints[0]?.distanceTo(listSelectedPoints[1]!);
    final height = listSelectedPoints[0]?.distanceTo(listSelectedPoints[3]!);

    final middleTop =
        _getMiddleVector(listSelectedPoints[0]!, listSelectedPoints[1]!);
    final middleBottom =
        _getMiddleVector(listSelectedPoints[2]!, listSelectedPoints[3]!);
    final middlePoint = _getMiddleVector(middleTop, middleBottom);

    // final middleSphere = ARKitSphere(radius: 0.01, materials: [
    //   ARKitMaterial(
    //     diffuse: ARKitMaterialProperty.color(Colors.blue),
    //   )
    // ]);

    // final middleNode = ARKitNode(
    //   geometry: middleSphere,
    //   position: middlePoint,
    // );

    // final firstTopNode = ARKitNode(
    //   geometry: middleSphere,
    //   position: firstTopPoint,
    // );

    // final secondTopNode = ARKitNode(
    //   geometry: middleSphere,
    //   position: secondTopPoint,
    // );

    // arkitController.value?.add(firstTopNode);
    // arkitController.value?.add(secondTopNode);

    // arkitController.value?.add(middleNode);

    final selectedPlane = ARKitPlane(
      width: width ?? 0,
      height: height ?? 0,
      materials: [
        ARKitMaterial(
          transparency: 0.7,
          diffuse: ARKitMaterialProperty.color(Colors.green),
        )
      ],
    );

    planeAngle = MathHelper.calculateAngle2Vectors(
        vector.Vector3(
            listSelectedPoints[1]!.x - listSelectedPoints[0]!.x,
            listSelectedPoints[1]!.y - listSelectedPoints[0]!.y,
            listSelectedPoints[1]!.z - listSelectedPoints[0]!.z),
        vector.Vector3(1, 0, 0));

    planeDirection.value = MathHelper.calculateDirectionVector(
        listSelectedPoints[0]!, listSelectedPoints[1]!);

    print("------- ANGLE: ${planeAngle}");
    print("------- DIRECTION: ${planeDirection}");

    if (planeAngle > math.pi / 2) {
      planeAngle = -planeAngle;
    }

    selectedPlaneNode.value = ARKitNode(
      geometry: selectedPlane,
      position: middlePoint,
      rotation: orientationVertical.value
          ? vector.Vector4(1, 0, 0, planeAngle)
          : vector.Vector4(1, 0, 0, (-math.pi / 2)),
      // eulerAngles: orientationVertical.value ? vector.Vector3(
      //     (planeDirection.value! > 0) ? planeAngle : -planeAngle, 0, 0) : vector.Vector3(0, 0, 0)
    );

    arkitController.value?.add(selectedPlaneNode.value!);
    currentStatus.value = ARSessionStatus.bottomPointsSelected;
  }

  // createTopPoints() {
  //   for (var i = 2; i <= 3; i++) {
  //     final position = vector.Vector3(listSelectedPoints[i]!.x,
  //         listSelectedPoints[i]!.y, listSelectedPoints[i]!.z);
  //     final material = ARKitMaterial(
  //       lightingModelName: ARKitLightingModel.constant,
  //       diffuse: ARKitMaterialProperty.color(Colors.blue),
  //     );
  //     final sphere = ARKitSphere(
  //       radius: 0.01,
  //       materials: [material],
  //     );
  //     final node = ARKitNode(
  //       geometry: sphere,
  //       position: position,
  //     );
  //     arkitController.value?.add(node);
  //     if (listSelectedPoints.isNotEmpty) {
  //       final line = ARKitLine(
  //           fromVector: listSelectedPoints[i - 1]!,
  //           toVector: position,
  //           materials: [
  //             ARKitMaterial(
  //               diffuse: ARKitMaterialProperty.color(Colors.red),
  //             )
  //           ]);
  //       final lineNode = ARKitNode(geometry: line);
  //       arkitController.value?.add(lineNode);

  //       final distance = _calculateDistanceBetweenPoints(
  //           position, listSelectedPoints[i - 1]!);
  //       final point = _getMiddleVector(position, listSelectedPoints[i - 1]!);
  //       _drawText(distance, point);
  //     }
  //   }
  // }

  void onARKitViewCreated(ARKitController arkitController) {
    final sphere = ARKitSphere(
      materials: [
        ARKitMaterial(diffuse: ARKitMaterialProperty.color(Colors.red))
      ],
      radius: 0.01,
    );

    movingNode.value = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.25),
    );

    this.arkitController.value = arkitController;

    if (!orientationVertical.value) {
      this.arkitController.value!.onAddNodeForAnchor = _handleAddAnchor;
      this.arkitController.value!.onUpdateNodeForAnchor = _handleUpdateAnchor;
    }

    this.arkitController.value?.updateAtTime = (time) {
      if (busy.value == false) {
        busy.value = true;
        this
            .arkitController
            .value
            ?.performHitTest(x: 0.5, y: 0.5)
            .then((results) {
          if (results.isNotEmpty) {
            final point = results.firstWhereOrNull(
              (o) => o.type == ARKitHitTestResultType.featurePoint,
            );
            if (point == null) {
              return;
            }
            final position = vector.Vector3(
              point.worldTransform.getColumn(3).x,
              point.worldTransform.getColumn(3).y,
              point.worldTransform.getColumn(3).z,
            );

            final newSphereNode = ARKitNode(
              geometry: sphere,
              position: position,
            );

            this.arkitController.value?.remove(movingNode.value!.name);

            movingNode.value = null;

            this.arkitController.value?.add(newSphereNode);
            movingNode.value = newSphereNode;
          }
          busy.value = false;
        });

        if (currentStatus.value == ARSessionStatus.bottomPointsSelected) {
          if (orientationVertical.value) {
            if (movingNode.value!.position.y != listSelectedPoints[2]?.y) {
              listSelectedPoints[2]?.y = movingNode.value!.position.y;
              listSelectedPoints[3]?.y = movingNode.value!.position.y;
              updateNodeWhenMesureHeight();
            }
          } else {
            if (movingNode.value!.position.z != listSelectedPoints[2]?.z) {
              listSelectedPoints[2]?.z = movingNode.value!.position.z;
              listSelectedPoints[3]?.z = movingNode.value!.position.z;
              updateNodeWhenMesureHeight();
            }
          }
        }
      }
    };

    this.arkitController.value?.add(movingNode.value!);
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }
    _addPlane(arkitController.value!, anchor);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId) {
      return;
    }
    final planeAnchor = anchor as ARKitPlaneAnchor;
    node!.position =
        vector.Vector3(planeAnchor.center.x, 0, planeAnchor.center.z);
    plane?.width.value = planeAnchor.extent.x;
    plane?.height.value = planeAnchor.extent.z;
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;
    plane = ARKitPlane(
      width: anchor.extent.x,
      height: anchor.extent.z,
      materials: [
        ARKitMaterial(
          transparency: 0.8,
          diffuse: ARKitMaterialProperty.color(Colors.white),
        )
      ],
    );

    node = ARKitNode(
      geometry: plane,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: orientationVertical.value
          ? vector.Vector4(1, 0, 0, 0)
          : vector.Vector4(1, 0, 0, -math.pi / 2),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }

  void updateNodeWhenMesureHeight() {
    final width = listSelectedPoints[0]?.distanceTo(listSelectedPoints[1]!);
    final height = listSelectedPoints[0]?.distanceTo(listSelectedPoints[3]!);

    final middleTop =
        _getMiddleVector(listSelectedPoints[0]!, listSelectedPoints[1]!);
    final middleBottom =
        _getMiddleVector(listSelectedPoints[2]!, listSelectedPoints[3]!);
    final middlePoint = _getMiddleVector(middleTop, middleBottom);

    double displayedWidth = 0;
    double displayedHeight = 0;

    if (currentStatus.value == ARSessionStatus.heightSelected) {
      displayedWidth = displayedImage.width *
          Numeral.pixelToMeter *
          double.parse(arguments["scale"]);
      displayedHeight = displayedImage.height *
          Numeral.pixelToMeter *
          double.parse(arguments["scale"]);
    } else {
      displayedWidth = width ?? 0;
      displayedHeight = height ?? 0;
    }

    final selectedPlane = ARKitPlane(
      width: displayedWidth,
      height: displayedHeight,
      materials: [
        (currentStatus.value == ARSessionStatus.heightSelected)
            ? ARKitMaterial(
                transparency: 0.8,
                diffuse: ARKitMaterialProperty.image(
                    Helper.convertImageToBase64(file: arguments["file"])),
              )
            : ARKitMaterial(
                transparency: 0.7,
                diffuse: ARKitMaterialProperty.color(Colors.green),
              )
      ],
    );

    if (planeAngle > math.pi / 2) {
      planeAngle = -planeAngle;
    }

    final newPlaneNode = ARKitNode(
      geometry: selectedPlane,
      position: middlePoint,
      rotation: orientationVertical.value
          ? vector.Vector4(1, 0, 0, planeAngle)
          : vector.Vector4(1, 0, 0, (-math.pi / 2)),

    );

    arkitController.value?.remove(selectedPlaneNode.value!.name);
    selectedPlaneNode.value = null;
    arkitController.value?.add(newPlaneNode);
    selectedPlaneNode.value = newPlaneNode;
  }

  void _drawText(String text, vector.Vector3 point) {
    final textGeometry = ARKitText(
      text: text,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.red),
        )
      ],
    );
    const scale = 0.001;
    final vectorScale = vector.Vector3(scale, scale, scale);
    final node = ARKitNode(
      geometry: textGeometry,
      position: point,
      scale: vectorScale,
    );
    arkitController.value
        ?.getNodeBoundingBox(node)
        .then((List<vector.Vector3> result) {
      final minVector = result[0];
      final maxVector = result[1];
      final dx = (maxVector.x - minVector.x) / 2 * scale;
      final dy = (maxVector.y - minVector.y) / 2 * scale;
      final position = vector.Vector3(
        node.position.x - dx,
        node.position.y - dy,
        node.position.z,
      );
      node.position = position;
    });
    arkitController.value?.add(node);
  }

  String _calculateDistanceBetweenPoints(vector.Vector3 A, vector.Vector3 B) {
    final length = A.distanceTo(B);
    return '${(length * 1).toStringAsFixed(2)} m';
  }

  vector.Vector3 _getMiddleVector(vector.Vector3 A, vector.Vector3 B) {
    return vector.Vector3((A.x + B.x) / 2, (A.y + B.y) / 2, (A.z + B.z) / 2);
  }

  @override
  void dispose() {
    arkitController.value?.updateAtTime = null;
    arkitController.value?.dispose();
    cameraController.value.dispose();
    super.dispose();
  }
}