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
        data: DataSet.remoteDatalist,
        docs: "",
        dataPath: await MkPath.forRemoteDataList(TechIds.remoteDataList.name),
        docsPath: await MkPath.forRemoteDataList(TechIds.remoteDataList.name),
      ),
      ContentPath(
        data: DataSet.reactjs,
        docs: DocsSet.reactjs,
        dataPath: await MkPath.forTechData(TechIds.reactJs.name),
        docsPath: await MkPath.forTechDocs(TechIds.reactJs.name),
      ),
      ContentPath(
        data: DataSet.tailwindcss,
        docs: "",
        dataPath: await MkPath.forTechData(TechIds.tailwindCss.name),
        docsPath: await MkPath.forTechDocs(TechIds.tailwindCss.name),
      ),
      ContentPath(
        data: DataSet.test,
        docs: "",
        dataPath: await MkPath.forTechData(TechIds.test.name),
        docsPath: await MkPath.forTechDocs(TechIds.test.name),
      ),
    ];
