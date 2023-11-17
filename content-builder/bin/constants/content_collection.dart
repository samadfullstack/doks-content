import '../content/reactjs_content.dart';
import '../content/remote_data_list.dart';

class ContentCollection {
  static String get reactjs => reactjsContent.toJson().toString();
  static String get remoteDatalist =>
      remoteDataList.map((e) => e.toJson()).toList().toString();
}
