import '../../models/models.dart';
import '../../constants/tech_ids.dart';
import '../../utils/link_maker.dart';
import 'ids.dart';

TechModel reactjsContent = TechModel(
  hidden: false,
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
