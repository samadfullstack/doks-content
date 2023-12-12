import '../abstract/abstract.dart';
import '../constants/tech_ids.dart';
import '../models/models.dart';
import '../utils/link_maker.dart';
import 'reactjs/ids.dart';

class Reactjs implements AbstractTechData {
  @override
  String get id => TechIds.reactJs.name;

  @override
  List<String> get fileNames => [
        ...Hooks.values.map((e) => e.name),
        ...Components.values.map((e) => e.name),
        ...Images.values.map((e) => e.name),
        ...Apis.values.map((e) => e.name),
        ...Directives.values.map((e) => e.name),
      ];

  @override
  TechModel get data => TechModel(
        isSubTech: false,
        version: "18.2.0",
        downloadSize: "987 kb",
        id: TechIds.reactJs.name,
        techTitle: TechIds.reactJs.name,
        description: "Front-end javascript library",
        docsUrl: MkLink.docs(TechIds.reactJs.name),
        related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
        sectionsList: [
          SectionModel(
            sectionTitle: "Hooks",
            docList: Hooks.values.map((doc) => doc.prefix).toList(),
          ),
          SectionModel(
            sectionTitle: "Components",
            docList: Components.values.map((doc) => doc.prefix).toList(),
          ),
          SectionModel(
            sectionTitle: "Apis",
            docList: Apis.values.map((doc) => doc.prefix).toList(),
          ),
          SectionModel(
            sectionTitle: "Directives",
            docList: Directives.values.map((doc) => doc.prefix).toList(),
          ),
        ],
      );
}
