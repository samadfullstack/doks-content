import '../../models/models.dart';
import 'ids.dart';
import 'data.dart' show reactJsBaseUrl;

List<DocModel> reactjsDocs = [
  // hooks section
  ...Hooks.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/content/${item.name}.md",
    );
  }),

  //
  ...Components.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/content/${item.name}.md",
    );
  }),
  //
  ...Apis.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/content/${item.name}.md",
    );
  }),
  //
  ...Directives.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/content/${item.name}.md",
    );
  }),
];
