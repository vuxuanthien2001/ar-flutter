import 'dart:io';
import 'package:ar_flutter/modules/home/controllers/home_controller.dart';
import 'package:ar_flutter/modules/home/models/session_model.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionWidget extends StatefulWidget {
  final SessionModel sessionModel;
  final String localDirectory;
  const SessionWidget(
      {super.key, required this.sessionModel, required this.localDirectory});

  @override
  State<SessionWidget> createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Colors.black12.withOpacity(0.05),
                spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        children: [
          (widget.localDirectory.isEmpty)
              ? const CircularProgressIndicator()
              : Image.file(
                  File(
                      "${widget.localDirectory}/${widget.sessionModel.imagePath}"),
                  height: Get.width * 0.3,
                  fit: BoxFit.cover,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sessionModel.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${"scaling_ratio".tr}: ${widget.sessionModel.scalingRatio.toString()}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey),
                    )
                  ],
                ),
              ),
              PopupMenuButton<EditSessionItem>(
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.lightGrey,
                ),
                onSelected: (EditSessionItem item) {
                  if (item == EditSessionItem.delete) {
                    deleteSession();
                  } else if (item == EditSessionItem.edit) {
                    Get.toNamed(Routes.EDIT_SESSION,
                        arguments: widget.sessionModel);
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<EditSessionItem>>[
                  PopupMenuItem<EditSessionItem>(
                    value: EditSessionItem.edit,
                    child: Text("edit".tr),
                  ),
                  PopupMenuItem<EditSessionItem>(
                    value: EditSessionItem.delete,
                    child: Text('delete'.tr),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void deleteSession() {
    // Delete image file
    File file =
        File("${widget.localDirectory}/${widget.sessionModel.imagePath}");
    file.delete();
    // Delete session
    Get.find<AuthService>().deleteSessions(widget.sessionModel);
    // Refresh sessions
    Get.find<HomeController>().refreshSavedSessions();
  }
}
