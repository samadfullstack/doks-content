import 'dart:io';
import 'package:path/path.dart' as pathpkg;

buildPathInData(String fileName) =>
    pathpkg.joinAll(["D:", "doks-content", "data", fileName]);

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
