import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import 'ids.dart';

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.reactJs.name}/content";

List<DocModel> reactjsDocs = [
  // hooks section
  ...Hooks.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix(),
      url: "$_baseUrl/${item.name}.md",
    );
  }),

  //
  ...Components.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix(),
      url: "$_baseUrl/${item.name}.md",
    );
  }),
  //
  ...Apis.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix(),
      url: "$_baseUrl/${item.name}.md",
    );
  }),
  //
  ...Directives.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix(),
      url: "$_baseUrl/${item.name}.md",
    );
  }),
];
