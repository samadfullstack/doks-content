import '../content/reactjs_content.dart';
import '../content/remote_data_list.dart';

class ContentCollection {
  static String get reactjsData => reactjsContent.toJson().toString();
  static String get remoteData =>
      remoteDataList.map((e) => e.toJson()).toList().toString();
}
