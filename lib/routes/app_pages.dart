import 'package:ar_flutter/main_navigate_page.dart';
import 'package:ar_flutter/modules/add_session/bindings/add_session_binding.dart';
import 'package:ar_flutter/modules/add_session/pages/add_session_page.dart';
import 'package:ar_flutter/modules/change_language/bindings/change_language_binding.dart';
import 'package:ar_flutter/modules/change_language/pages/change_language_page.dart';
import 'package:ar_flutter/modules/edit_session/bindings/edit_session_binding.dart';
import 'package:ar_flutter/modules/edit_session/pages/edit_session_page.dart';
import 'package:ar_flutter/modules/help_support/bindings/help_support_binding.dart';
import 'package:ar_flutter/modules/help_support/pages/help_support_page.dart';
import 'package:ar_flutter/modules/home/bindings/home_binding.dart';
import 'package:ar_flutter/modules/home/pages/home_page.dart';
import 'package:ar_flutter/modules/plane_detection/bindings/plane_detection_binding.dart';
import 'package:ar_flutter/modules/plane_detection/pages/plane_detection_page.dart';
import 'package:ar_flutter/modules/policy_privacy/bindings/policy_privacy_binding.dart';
import 'package:ar_flutter/modules/policy_privacy/pages/policy_privacy_page.dart';
import 'package:ar_flutter/modules/project_blueprint/bindings/project_blueprint_binding.dart';
import 'package:ar_flutter/modules/project_blueprint/pages/project_blueprint_page.dart';
import 'package:ar_flutter/modules/search_session/bindings/search_session_binding.dart';
import 'package:ar_flutter/modules/search_session/pages/search_session_page.dart';
import 'package:ar_flutter/modules/settings/bindings/settings_binding.dart';
import 'package:ar_flutter/modules/settings/pages/settings_page.dart';
import 'package:ar_flutter/modules/splash/bindings/splash_binding.dart';
import 'package:ar_flutter/modules/splash/pages/splash_page.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashPage(),
        bindings: [SplashBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.MAIN_NAVIGATE,
        page: () => const MainNavigatePage(),
        bindings: [HomeBinding(), SettingsBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomePage(),
        bindings: [HomeBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.ADD_SESSION,
        page: () => const AddSessionPage(),
        bindings: [AddSessionBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.EDIT_SESSION,
        page: () => const EditSessionPage(),
        bindings: [EditSessionBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => const SettingsPage(),
        bindings: [SettingsBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.PROJECT_BLUEPRINT,
        page: () => const ProjectBlueprintPage(),
        bindings: [ProjectBlueprintBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.SEARCH_SESSION,
        page: () => const SearchSessionPage(),
        bindings: [SearchSessionBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.POLICY_PRIVACY,
        page: () => const PolicyPrivacyPage(),
        bindings: [PolicyPrivacyBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.CHANGE_LANGUAGE,
        page: () => const ChangeLanguagePage(),
        bindings: [ChangeLanguageBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.HELP_SUPPORT,
        page: () => const HelpSupportPage(),
        bindings: [HelpSupportBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
    GetPage(
        name: _Paths.PLANE_DETECTION,
        page: () => PlaneDetectionPage(),
        bindings: [PlaneDetectionBinding()],
        transitionDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut),
  ];
}
