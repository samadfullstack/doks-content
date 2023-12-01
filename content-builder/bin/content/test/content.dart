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
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  sectionsList: [
    SectionModel(
      sectionTitle: "Level 1 Section",
      docList: [
        DocModel(
          docTitle: "Level 1 doc1",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Level 1 doc2",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Level 1 doc3",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Level 1 doc4",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Level 1 doc5",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Level 1 doc6",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
      ],
      subSections: [
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [
            DocModel(
              docTitle: "Level 2 doc1",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc2",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc3",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc4",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc5",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc6",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
          ],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [
            DocModel(
              docTitle: "Level 2 doc1",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc2",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc3",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc4",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc5",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc6",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
          ],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [
            DocModel(
              docTitle: "Level 2 doc1",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc2",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc3",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc4",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc5",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc6",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
          ],
        ),
        SectionModel(
          sectionTitle: "Level 2 Section",
          docList: [
            DocModel(
              docTitle: "Level 2 doc1",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc2",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc3",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc4",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc5",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
            DocModel(
              docTitle: "Level 2 doc6",
              url: "$_baseUrl/hooks.md",
              markdown: "",
              keywords: [],
            ),
          ],
          subSections: [
            SectionModel(
              sectionTitle: "Level 3 Section",
              docList: [
                DocModel(
                  docTitle: "Level 3 doc1",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
                DocModel(
                  docTitle: "Level 3 doc2",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
                DocModel(
                  docTitle: "Level 3 doc3",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
                DocModel(
                  docTitle: "Level 3 doc4",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
                DocModel(
                  docTitle: "Level 3 doc5",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
                DocModel(
                  docTitle: "Level 3 doc6",
                  url: "$_baseUrl/hooks.md",
                  markdown: "",
                  keywords: [],
                ),
              ],
              subSections: [
                SectionModel(
                  sectionTitle: "Level 4 Section",
                  docList: [
                    DocModel(
                      docTitle: "Level 4 doc1",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                    DocModel(
                      docTitle: "Level 4 doc2",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                    DocModel(
                      docTitle: "Level 4 doc3",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                    DocModel(
                      docTitle: "Level 4 doc4",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                    DocModel(
                      docTitle: "Level 4 doc5",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                    DocModel(
                      docTitle: "Level 4 doc6",
                      url: "$_baseUrl/hooks.md",
                      markdown: "",
                      keywords: [],
                    ),
                  ],
                  subSections: [
                    SectionModel(
                      sectionTitle: "Level 5 Section",
                      docList: [
                        DocModel(
                          docTitle: "Level 5 doc1",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
                        ),
                        DocModel(
                          docTitle: "Level 5 doc2",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
                        ),
                        DocModel(
                          docTitle: "Level 5 doc3",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
                        ),
                        DocModel(
                          docTitle: "Level 5 doc4",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
                        ),
                        DocModel(
                          docTitle: "Level 5 doc5",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
                        ),
                        DocModel(
                          docTitle: "Level 5 doc6",
                          url: "$_baseUrl/hooks.md",
                          markdown: "",
                          keywords: [],
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
    ),
  ],
);
