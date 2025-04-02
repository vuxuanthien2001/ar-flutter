import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

/// Dialog loading
Future showLoading() async {
  return showDialog(
    routeSettings: const RouteSettings(name: "showDialog"),
    barrierDismissible: false,
    context: Get.context!,
    useRootNavigator: true,
    builder: (context) => Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.2,
          height: Get.width * 0.2,
          child: Lottie.asset("assets/jsons/loading.json", fit: BoxFit.fill),
        ),
      ),
    ),
  );
}

closeLoading() {
  final context = Get.overlayContext;
  if (context != null) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.settings.name != "showDialog");
  }
}