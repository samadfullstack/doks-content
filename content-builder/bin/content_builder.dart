import 'constants/content_collection.dart';
import 'utils/utils.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) async {
  contentWriter(
    path: buildPathInData("remote_data_list.json"),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: buildPathInData("reactjs.json"),
    data: ContentCollection.reactjs,
  );

  http
      .get(Uri.parse(
          "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/remote_data_list.json"))
      .then((data) => print(data.body));

  print("Completed content writing");
}
