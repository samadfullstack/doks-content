import 'dart:io';
import 'package:path/path.dart' as pathpkg;

Future<String> buildPathInData(String fileName) async {
  String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", fileName]);

  // create tech folder if it doesn't exist
  var techDir = Directory(dirPath);
  if (!await techDir.exists()) techDir.create();

  return pathpkg.joinAll([dirPath, "$fileName.json"]);
}

Future<String> buildPathMetaData(String fileName) async {
  String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", "meta-data"]);

  // create tech folder if it doesn't exist
  var techDir = Directory(dirPath);
  if (!await techDir.exists()) techDir.create();

  return pathpkg.joinAll([dirPath, "$fileName.json"]);
}

// * >----------------------------
contentWriter({required String path, data}) async {
  // create file on this dir
  File file = File(path);
  if (!await file.exists()) file.create();

  // write data to file and catch any error that may occur
  file.writeAsString(data).catchError((error) {
    print("error occured : $error");
    return error;
  });
}
