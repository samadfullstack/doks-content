import '../../models/models.dart';
import '../../constants/tech_ids.dart';

String tailwindCssBaseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.tailwindCss.name}";

TechModel tailwindCssContent = TechModel(
  id: TechIds.tailwindCss.name,
  techTitle: TechIds.tailwindCss.name,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  sectionsList: [],
  hidden: true,
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  docsUrl: "$tailwindCssBaseUrl/docs.json",
);
