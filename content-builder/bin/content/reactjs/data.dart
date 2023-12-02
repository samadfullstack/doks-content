import '../../models/models.dart';
import '../../constants/tech_ids.dart';
import 'ids.dart';

String reactJsBaseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.reactJs.name}";

TechModel reactjsContent = TechModel(
  techTitle: TechIds.reactJs.name,
  id: TechIds.reactJs.id,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  docsUrl: "$reactJsBaseUrl/docs.json",
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
