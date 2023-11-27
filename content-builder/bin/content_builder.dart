import 'constants/content_collection.dart';
import 'models/tech_ids.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  contentWriter(
    path: buildPathInData("${TechIds.remotedatalist}.json"),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: buildPathInData("${TechIds.reactjs}.json"),
    data: ContentCollection.reactjs,
  );
  contentWriter(
    path: buildPathInData("${TechIds.tailwindcss}.json"),
    data: ContentCollection.tailwindcss,
  );
  contentWriter(
    path: buildPathInData("${TechIds.test}.json"),
    data: ContentCollection.test,
  );

  print("Completed content writing");
}
