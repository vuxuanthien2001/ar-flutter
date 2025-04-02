import 'package:ar_flutter/modules/home/controllers/home_controller.dart';
import 'package:ar_flutter/modules/home/widgets/session_widget.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryGrey,
        appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            title: GestureDetector(
              onTap: () {
                // Get.find<AuthService>().clearAllSessions();
                controller.refreshSavedSessions();
              },
              child: Text('home_title'.tr,
                  style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH_SESSION);
                  },
                  child: SvgPicture.asset("assets/icons/ic_search.svg",
                      color: AppColors.hardGrey),
                ),
              )
            ]),
        floatingActionButton: GestureDetector(
          onTap: () => Get.toNamed(Routes.ADD_SESSION),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryBlue),
              child: Icon(
                Icons.add,
                size: 30,
                color: AppColors.primaryGrey,
              )),
        ),
        body: Obx(
          () => controller.savedSessions.isEmpty ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    "assets/icons/ic_empty_box.svg",
                    height: Get.width * 0.5,
                  ),
                  Text("have_not_added_any_session_yet".tr, style: TextStyle(fontSize: 20, color: AppColors.hardGrey),)
              ],
            ),
          ) : SingleChildScrollView(
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
                          controller.savedSessions.length,
                          (index) => GestureDetector(
                              onTap: () {
                                controller.startARSession(index);
                              },
                              child: SessionWidget(
                                sessionModel: controller.savedSessions[index],
                                localDirectory: controller.localDirectory.value,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
