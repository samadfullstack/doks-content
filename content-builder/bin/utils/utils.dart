import 'dart:io';
import 'package:path/path.dart' as pathpkg;

Future<String> buildPathInDocs(String fileName) async {
  String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", fileName]);

  // create tech folder if it doesn't exist
  var techDir = Directory(dirPath);
  if (!await techDir.exists()) techDir.create();

  return pathpkg.joinAll([dirPath, "data.json"]);
}

Future<String> buildPathInMetaData(String fileName) async {
  String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", "meta-data"]);

  // create tech folder if it doesn't exist
  var techDir = Directory(dirPath);
  if (!await techDir.exists()) techDir.create();

  return pathpkg.joinAll([dirPath, "$fileName.json"]);
}

