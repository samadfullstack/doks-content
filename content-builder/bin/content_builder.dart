import 'constants/content_collection.dart';
import 'constants/tech_ids.dart';
import 'utils/content_writer.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  ContentWriter.write(
    path: await buildPathInMetaData(TechIds.remoteDataList.name),
    data: ContentCollection.remoteDatalist,
  );
  ContentWriter.write(
    path: await buildPathInDocs(TechIds.reactJs.name),
    data: ContentCollection.reactjs,
  );
  ContentWriter.write(
    path: await buildPathInDocs(TechIds.tailwindCss.name),
    data: ContentCollection.tailwindcss,
  );
  ContentWriter.write(
    path: await buildPathInDocs(TechIds.test.name),
    data: ContentCollection.test,
  );

  // TechIds.values.forEach((element) => print(element.name));

  print("Completed content writing");
}
