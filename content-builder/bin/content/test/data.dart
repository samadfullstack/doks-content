import '../../models/models.dart';
import '../../constants/tech_ids.dart';
import '../reactjs/ids.dart';

String testContentBaseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.test.name}";

TechModel testContent = TechModel(
  techTitle: TechIds.test.name,
  id: TechIds.test.name,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  docsUrl: "$testContentBaseUrl/docs.json",
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  sectionsList: [
    SectionModel(
      sectionTitle: "Level 1 Section",
      docList: Hooks.values.map((e) => e.prefix).toList(),
      subSections: [
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: Components.values.map((e) => e.prefix).toList(),
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: Components.values.map((e) => e.prefix).toList(),
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: Components.values.map((e) => e.prefix).toList(),
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: Components.values.map((e) => e.prefix).toList(),
          subSections: [
            SectionModel(
              sectionTitle: "Level 3 Section",
              docList: Apis.values.map((e) => e.prefix).toList(),
              subSections: [
                SectionModel(
                  sectionTitle: "Level 4 Section",
                  docList: Hooks.values.map((e) => e.prefix).toList(),
                  subSections: [
                    SectionModel(
                      sectionTitle: "Level 5 Section",
                      docList: Directives.values.map((e) => e.prefix).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
