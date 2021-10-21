
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class SaveImage {
  ///アプリ内のストレージ領域に選択したimageを保存。
  static Future saveLocalImage(PickedFile image) async {
    //ストレージパス取得
    final path = await localPath;
    final String fileName = basename(image.path);
    final imagePath = '$path/$fileName';
    //SharePreferenceで画像のストレージパスを保存
    SharedPrefWrite(imagePath);
    File imageFile = File(imagePath);
    //選択した画像をByteDataにしてリターン
    var saveFile = await imageFile.writeAsBytes(await image.readAsBytes());
    return saveFile;
  }

  ///path_providerでアプリ内のストレージ領域を確保。
  static Future get localPath async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    return path;
  }

  ///SharePreferenceにimageのpathを書き込む。
  static Future SharedPrefWrite(imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', imagePath);
  }
}


