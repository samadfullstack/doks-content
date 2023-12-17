import 'dart:io';

import 'package:path/path.dart' as pth;

import '../content/tech_content_list.dart';
import '../models/models.dart';
import '../utils/link_maker.dart';

writeContent() async {
  var doksDir = pth.joinAll(["D:", "doks-content", "doks"]);

  List<MetaData> metaDataList = [];

  for (var tech in techContentList) {
    metaDataList.add(
      MetaData(id: tech.id, version: tech.version, objUrl: MkLink.data(tech.id)),
    );

    String dir = pth.joinAll([doksDir, tech.id]);
    Directory(dir).create(recursive: true);

    var docs = tech.fileNames
        .map((item) => DocModel(
            docTitle: item, id: "${tech.id}:$item", url: MkLink.content(tech.id, item)))
        .toList();

    String dataPath = pth.joinAll([dir, "data.json"]);
    String docsPath = pth.joinAll([dir, "docs.json"]);

    var dataFile = await File(dataPath).create(recursive: true);
    var docsFile = await File(docsPath).create(recursive: true);

    await dataFile.writeAsString(tech.data.toJson());
    await docsFile.writeAsString(DocsListAdapter(docs: docs).toJson());
  }

  var metaData = MetaDataAdapter(list: metaDataList);

  var remoteDataListFile = await File(pth.joinAll(
    [doksDir, "meta-data", "remoteDataList.json"],
  )).create(recursive: true);

  await remoteDataListFile.writeAsString(metaData.toJson());
}
