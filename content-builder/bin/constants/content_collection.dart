import '../content/all_exports.dart';

class ContentCollection {
  static String get reactjs => reactjsContent.toJson().toString();
  static String get tailwindcss => tailwindCssContent.toJson().toString();
  static String get remoteDatalist => remoteDataList.toJson().toString();
}
