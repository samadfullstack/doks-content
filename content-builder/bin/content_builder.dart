import 'constants/content_collection.dart';
import 'models/tech_ids.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  contentWriter(
    path: await buildPathInMetaData(TechIds.remotedatalist),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.reactjs),
    data: ContentCollection.reactjs,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.tailwindcss),
    data: ContentCollection.tailwindcss,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.test),
    data: ContentCollection.test,
  );

  print("Completed content writing");
}
