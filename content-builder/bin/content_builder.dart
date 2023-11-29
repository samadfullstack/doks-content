import 'constants/content_collection.dart';
import 'models/tech_ids.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  contentWriter(
    path: await buildPathMetaData(TechIds.remotedatalist),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: await buildPathInData(TechIds.reactjs),
    data: ContentCollection.reactjs,
  );
  contentWriter(
    path: await buildPathInData(TechIds.tailwindcss),
    data: ContentCollection.tailwindcss,
  );
  contentWriter(
    path: await buildPathInData(TechIds.test),
    data: ContentCollection.test,
  );

  print("Completed content writing");
}
