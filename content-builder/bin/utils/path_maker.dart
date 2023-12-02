import 'dart:io';
import 'package:path/path.dart' as pathpkg;

class MkPath {
  static Future<String> forTechDataInDocs(String fileName) async {
    String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", fileName]);

    // create tech folder if it doesn't exist
    var techDir = Directory(dirPath);
    if (!await techDir.exists()) techDir.create();

    return pathpkg.joinAll([dirPath, "data.json"]);
  }

  static Future<String> forTechDocsInDocs(String fileName) async {
    String dirPath = pathpkg.joinAll(["D:", "doks-content", "docs", fileName]);

    // create tech folder if it doesn't exist
    var techDir = Directory(dirPath);
    if (!await techDir.exists()) techDir.create();

    return pathpkg.joinAll([dirPath, "docs.json"]);
  }

  static Future<String> forRemoteDataList(String fileName) async {
    String dirPath =
        pathpkg.joinAll(["D:", "doks-content", "docs", "meta-data"]);

    // create tech folder if it doesn't exist
    var techDir = Directory(dirPath);
    if (!await techDir.exists()) techDir.create();

    return pathpkg.joinAll([dirPath, "$fileName.json"]);
  }

  static Future<String> inDocsCollection(String fileName) async {
    String dirPath =
        pathpkg.joinAll(["D:", "doks-content", "docs", "docsCollection"]);

    // create tech folder if it doesn't exist
    var techDir = Directory(dirPath);
    if (!await techDir.exists()) techDir.create();

    return pathpkg.joinAll([dirPath, "$fileName.json"]);
  }
}
