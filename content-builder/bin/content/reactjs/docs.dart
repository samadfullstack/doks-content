import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import 'ids.dart';
import 'data.dart';

List<DocModel> reactjsDocs = [
  // hooks section
  ...Hooks.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/${item.name}.md",
    );
  }),

  //
  ...Components.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/${item.name}.md",
    );
  }),
  //
  ...Apis.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/${item.name}.md",
    );
  }),
  //
  ...Directives.values.map((item) {
    return DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: "$reactJsBaseUrl/${item.name}.md",
    );
  }),
];
