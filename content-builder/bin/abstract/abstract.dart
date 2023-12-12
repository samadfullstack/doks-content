import 'dart:io';

import '../content/reactjs.dart';
import '../models/models.dart';
import '../utils/link_maker.dart';
import 'package:path/path.dart' as pth;

var docsCollection = <AbstractTechData>[Reactjs()];

abstract class AbstractTechData {
  /// a unique prefix that will be used to find this tech. this will be used as tech id
  String get id;

  /// this data will be used to build sections in this tech doc
  TechModel get data;

  /// files that are used in this tech
  List<String> get fileNames;
}

main() async {
  var doks = pth.joinAll(["D:", "doks-content", "doks"]);

  for (var tech in docsCollection) {
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

    await File(dataPath).create(recursive: true);
    await File(docsPath).create(recursive: true);

    await File(dataPath).writeAsString(tech.data.toJson());
    await File(docsPath).writeAsString(DocsListAdapter(docs: docs).toJson());
  }
}
