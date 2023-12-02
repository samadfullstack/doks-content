import '../../models/models.dart';
import '../all_exports.dart';
import '../reactjs/ids.dart';

List<DocModel> testDocs = [
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
