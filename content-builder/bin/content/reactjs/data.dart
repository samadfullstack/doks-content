import '../../models/models.dart';
import '../../constants/tech_ids.dart';
import 'ids.dart';

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.reactJs.name}/content";

TechModel reactjsContent = TechModel(
  techTitle: TechIds.reactJs.name,
  id: TechIds.reactJs.name,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  sectionsList: [
    SectionModel(
      sectionTitle: "Hooks",
      docList: [
        ...Hooks.values.map((item) {
          return DocModel(
            docTitle: item.name,
            // id: item.prefix(),
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Components",
      docList: [
        ...Components.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Apis",
      docList: [
        ...Apis.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Directives",
      docList: [
        ...Directives.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
  ],
);
