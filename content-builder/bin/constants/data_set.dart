import '../content/all_exports.dart';

class DataSet {
  static String get reactjs => reactjsContent.toJson().toString();
  static String get tailwindcss => tailwindCssContent.toJson().toString();
  static String get remoteDatalist => remoteDataList.toJson().toString();
  static String get test => testContent.toJson().toString();
}
