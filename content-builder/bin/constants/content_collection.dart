import '../content/all_exports.dart';

class ContentCollection {
  static String get reactjs => reactjsContent.toJson().toString();
  static String get remoteDatalist =>
      remoteDataList.map((e) => e.toJson()).toList().toString();
}
