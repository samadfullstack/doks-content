import 'constants/data_collection.dart';
import 'utils/content_writer.dart';
import 'constants/path_collection.dart';

void main(List<String> args) async {
  contentWriter(
    path: PathCollection.remoteDataListJson,
    data: ContentCollection.remoteData,
  );
  contentWriter(
    path: PathCollection.reactjsJson,
    data: ContentCollection.reactjsData,
  );

  print("Completed content writing");
}
