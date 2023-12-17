import 'dart:io';

import '../constants/data_set.dart';
import '../constants/docs_set.dart';
import '../constants/tech_ids.dart';
import 'path_maker.dart';

// >------------------------->>

class ContentWriter {
  static Future<void> write() async {
    for (var item in await getContentPathCollection()) {
      // ? >>---- Creating files
      File dataFile = await File(item.dataPath).create(recursive: true);
      File docsFile = await File(item.docsPath).create(recursive: true);
      // ? >>---- writing data and docs
      dataFile.writeAsString(item.data);
      docsFile.writeAsString(item.docs);
    }
  }
}

class DataDocsPaths {
  String dataPath;
  String docsPath;
  String data;
  String docs;
  DataDocsPaths({
    required this.dataPath,
    required this.docsPath,
    required this.data,
    required this.docs,
  });
}

Future<List<DataDocsPaths>> getContentPathCollection() async => [
      DataDocsPaths(
        data: DataSet.remoteDatalist,
        docs: "",
        dataPath: await MkPath.forMetaDataList(),
        docsPath: await MkPath.forMetaDataList(),
      ),
      DataDocsPaths(
        data: DataSet.reactjs,
        docs: DocsSet.reactjs,
        dataPath: await MkPath.forTechDataJson(TechIds.reactJs.name),
        docsPath: await MkPath.forTechDocsJson(TechIds.reactJs.name),
      ),
      DataDocsPaths(
        data: DataSet.tailwindcss,
        docs: DocsSet.tailwindCss,
        dataPath: await MkPath.forTechDataJson(TechIds.tailwindCss.name),
        docsPath: await MkPath.forTechDocsJson(TechIds.tailwindCss.name),
      ),
      DataDocsPaths(
        data: DataSet.test,
        docs: DocsSet.test,
        dataPath: await MkPath.forTechDataJson(TechIds.test.name),
        docsPath: await MkPath.forTechDocsJson(TechIds.test.name),
      ),
    ];
