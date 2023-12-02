import '../../models/models.dart';
import '../../constants/tech_ids.dart';

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.reactJs.name}/content";

TechModel testContent = TechModel(
  techTitle: TechIds.test.name,
  id: TechIds.test.name,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  docsUrl: "",
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  sectionsList: [
    SectionModel(
      sectionTitle: "Level 1 Section",
      docList: [],
      subSections: [
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [],
          subSections: [
            SectionModel(
              sectionTitle: "Level 3 Section",
              docList: [],
              subSections: [
                SectionModel(
                  sectionTitle: "Level 4 Section",
                  docList: [],
                  subSections: [
                    SectionModel(
                      sectionTitle: "Level 5 Section",
                      docList: [],
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
