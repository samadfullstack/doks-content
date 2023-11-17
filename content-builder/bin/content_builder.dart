import 'constants/content_collection.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  contentWriter(
    path: buildPathInData("remote_data_list.json"),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: buildPathInData("reactjs.json"),
    data: ContentCollection.reactjs,
  );
  contentWriter(
    path: buildPathInData("file.json"),
    data: ContentCollection.remoteDatalist,
  );

  print("Completed content writing");
}
