import 'dart:io';

import '../constants/data_set.dart';
import '../constants/docs_set.dart';
import '../constants/tech_ids.dart';
import 'path_maker.dart';

// >------------------------->>

class ContentWriter {
  static Future<void> write() async {
    for (var item in await getContentPathCollection()) {
      // ? >>---- files check
      File dataFile = File(item.dataPath);
      File docsFile = File(item.docsPath);
      if (!await dataFile.exists()) dataFile.create();
      if (!await docsFile.exists()) docsFile.create();

      // ? >>---- writing data and docs
      // write data to file and catch any error that may occur
      dataFile.writeAsString(item.data).catchError((error) {
        print("error occured : $error");
        return error;
      });
      docsFile.writeAsString(item.docs).catchError((error) {
        print("error occured : $error");
        return error;
      });
    }
  }
}

class ContentPath {
  String dataPath;
  String docsPath;
  String data;
  String docs;
  ContentPath({
    required this.dataPath,
    required this.docsPath,
    required this.data,
    required this.docs,
  });
}

Future<List<ContentPath>> getContentPathCollection() async => [
      ContentPath(
        dataPath: await MkPath.forRemoteDataList(TechIds.remoteDataList.name),
        docsPath: await MkPath.forRemoteDataList(TechIds.remoteDataList.name),
        data: DataSet.remoteDatalist,
        docs: "",
      ),
      ContentPath(
        dataPath: await MkPath.forTechDataInDocs(TechIds.reactJs.name),
        docsPath: await MkPath.forTechDocsInDocs(TechIds.reactJs.name),
        data: DataSet.reactjs,
        docs: DocsSet.reactjs,
      ),
      ContentPath(
        dataPath: await MkPath.forTechDataInDocs(TechIds.tailwindCss.name),
        docsPath: await MkPath.forTechDocsInDocs(TechIds.tailwindCss.name),
        data: DataSet.tailwindcss,
        docs: "",
      ),
      ContentPath(
        dataPath: await MkPath.forTechDataInDocs(TechIds.test.name),
        docsPath: await MkPath.forTechDocsInDocs(TechIds.test.name),
        data: DataSet.test,
        docs: "",
      ),
    ];
