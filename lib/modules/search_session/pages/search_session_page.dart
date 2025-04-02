import 'package:ar_flutter/modules/home/widgets/session_widget.dart';
import 'package:ar_flutter/modules/search_session/controllers/search_session_controller.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSessionPage extends GetView<SearchSessionController> {
  const SearchSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.hardGrey,
          ),
        ),
        title: TextFormField(
          controller: controller.searchController,
          autofocus: true,
            style: TextStyle(
                color: AppColors.primaryBlue, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                hintStyle: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                hintText: "search_sessions_here".tr)),
        actions: [
          GestureDetector(
            onTap: () {
              controller.searchSession();
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryBlue),
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Obx(
          () => (controller.searchedSessions.isNotEmpty) ? SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.1 / 3,
                      horizontal: Get.width * 0.1 / 3),
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      runSpacing: Get.width * 0.1 / 3,
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                          controller.searchedSessions.length,
                          (index) => GestureDetector(
                              onTap: () {
                                controller.startARSession(index);
                              },
                              child: SessionWidget(
                                sessionModel: controller.searchedSessions[index],
                                localDirectory: controller.localDirectory.value,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ) : Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/img_not_found.png", width: Get.width * 0.5,),
              Text("no_sessions_found".tr, style: TextStyle(fontSize: 20, color: AppColors.hardGrey),)
            ],
          )),
        ));
  }
}
