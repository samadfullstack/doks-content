import 'constants/content_collection.dart';
import 'constants/docs_collection.dart';
import 'constants/tech_ids.dart';
import 'utils/content_writer.dart';
import 'utils/path_maker.dart';

void main(List<String> args) async {
  ContentWriter.write(
    path: await MkPath.forRemoteDataList(TechIds.remoteDataList.name),
    data: ContentCollection.remoteDatalist,
  );
  ContentWriter.write(
    path: await MkPath.forTechDirInDocs(TechIds.reactJs.name),
    data: ContentCollection.reactjs,
  );
  ContentWriter.write(
    path: await MkPath.forTechDirInDocs(TechIds.tailwindCss.name),
    data: ContentCollection.tailwindcss,
  );
  ContentWriter.write(
    path: await MkPath.forTechDirInDocs(TechIds.test.name),
    data: ContentCollection.test,
  );
  ContentWriter.write(
    path: await MkPath.inDocsCollection("docsCollection"),
    data: docsCollection.toJson().toString(),
  );

  // TechIds.values.forEach((element) => print(element.name));

  print("Completed content writing");
}
