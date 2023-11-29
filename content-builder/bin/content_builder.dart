import 'constants/content_collection.dart';
import 'constants/tech_ids.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  contentWriter(
    path: await buildPathInMetaData(TechIds.remoteDataList.name),
    data: ContentCollection.remoteDatalist,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.reactJs.name),
    data: ContentCollection.reactjs,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.tailwindCss.name),
    data: ContentCollection.tailwindcss,
  );
  contentWriter(
    path: await buildPathInDocs(TechIds.test.name),
    data: ContentCollection.test,
  );

  // TechIds.values.forEach((element) => print(element.name));

  print("Completed content writing");
}
