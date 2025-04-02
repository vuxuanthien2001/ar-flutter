import 'package:ar_flutter/languages/language_service.dart';
import 'package:ar_flutter/routes/app_pages.dart';
import 'package:ar_flutter/service/auth_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ARKitController arkitController;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: LanguageService.locale,
      fallbackLocale: LanguageService.fallbackLocale,
      translations: LanguageService(),
      getPages: AppPages.routes,
      initialRoute: Routes.SPLASH,
    );
  }
}
