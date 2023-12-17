import 'dart:io';
import '../content/tech_content_list.dart';
import '../models/models.dart';
import 'link_maker.dart';
import 'path_maker.dart';

/// This will do the following things
/// 1. create docs.json list file using file names
/// 2. create data.json file from tech model
/// 3. create metaDataList.json from techContentList
Future<void> writeDataAndDocs() async {
  // ? STEP 1
  for (var tech in techContentList) {
    // creating docs list for this tech using fileNames
    var docs = tech.fileNames
        .map((item) => DocModel(
            docTitle: item, id: "${tech.id}:$item", url: MkLink.content(tech.id, item)))
        .toList();

    // creating recursive data.json and docs.json files
    var dataFile = await File(await MkPath.forTechDataJson(tech.id)).create(recursive: true);
    var docsFile = await File(await MkPath.forTechDocsJson(tech.id)).create(recursive: true);

    // writing tech data and techdocs to data.json and docs.json files
    await dataFile.writeAsString(tech.data.toJson());
    await docsFile.writeAsString(DocsListAdapter(docs: docs).toJson());
  }
}

// this will create metaDataList using techContent
Future<void> writeMetaData() async {
  // ? STEP 2
  // creating content for metadata
  var remoteDataListFile = await File(await MkPath.forMetaDataList()).create(recursive: true);

  // creating metaData for metaDataList
  List<MetaData> metaDataList = techContentList
      .map((tech) => MetaData(
            id: tech.id,
            version: tech.version,
            objUrl: MkLink.data(tech.id),
          ))
      .toList();

  // writing to metaDataList
  await remoteDataListFile.writeAsString(MetaDataAdapter(list: metaDataList).toJson());

  print("content written successfully _/");
}
