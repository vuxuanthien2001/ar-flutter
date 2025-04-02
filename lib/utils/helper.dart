import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Helper {
  static Future<String> saveFileToLocal(
      {required File file, required DateTime time}) async {
    String dir = (GetPlatform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory())!
        .path;
    String extension = Path.extension(file.path);

    Uint8List bytes = await file.readAsBytes();

    File newFile = File("$dir/${time.millisecondsSinceEpoch}$extension");

    await newFile.writeAsBytes(bytes);
    return "${time.millisecondsSinceEpoch}$extension";
  }

  static String convertImageToBase64({required File file}) {
    final fileBytes = file.readAsBytesSync();
    final byteData = Uint8List.fromList(fileBytes);
    final base64String = base64Encode(byteData);

    return base64String;
  }

  static showSnackBar(String title, String content) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(title, content);
    }
  }
}
