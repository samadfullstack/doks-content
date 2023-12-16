import 'dart:io';
import '../content/data_list.dart';
import '../models/models.dart';
import '../utils/link_maker.dart';
import 'package:path/path.dart' as pth;

abstract class AbstractTechData {
  /// a unique prefix that will be used to find this tech. this will be used as tech id
  String get id;

  /// this data will be used to build sections in this tech doc
  TechModel get data;

  /// files that are used in this tech
  List<String> get fileNames;

  /// version of this techData
  /// on each change in content of this tech, increment this number
  int get version;
}

main() async {
  var doks = pth.joinAll(["D:", "doks-content", "doks"]);

  List<MetaData> metaDataList = [];

  for (var tech in docsCollection) {
    metaDataList.add(MetaData(
      id: tech.id,
      version: tech.version,
      objUrl: MkLink.data(tech.id),
    ));

    String dir = pth.joinAll([doks, tech.id]);
    Directory(dir).create(recursive: true);

    var docs = tech.fileNames
        .map((item) => DocModel(
              docTitle: item,
              id: "${tech.id}:$item",
              url: MkLink.content(tech.id, item),
            ))
        .toList();

    String dataPath = pth.joinAll([dir, "data.json"]);
    String docsPath = pth.joinAll([dir, "docs.json"]);

    var dataFile = await File(dataPath).create(recursive: true);
    var docsFile = await File(docsPath).create(recursive: true);

    await dataFile.writeAsString(tech.data.toJson());
    await docsFile.writeAsString(DocsListAdapter(docs: docs).toJson());
  }

  var metaData = MetaDataAdapter(list: metaDataList);

  var remoteDataListFile = await File(pth.joinAll([doks, "meta-data", "remoteDataList.json"]))
      .create(recursive: true);

  await remoteDataListFile.writeAsString(metaData.toJson());
}
