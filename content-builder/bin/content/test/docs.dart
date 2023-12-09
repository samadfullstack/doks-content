import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';
import '../reactjs/ids.dart';

List<DocModel> testDocs = [
  ...Images.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name)
      // url: "$reactJsBaseUrl/content/${item.name}.md",
      )),
  ...Hooks.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name)
      // url: "$reactJsBaseUrl/content/${item.name}.md",
      )),
  ...Components.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name)
      // url: "$reactJsBaseUrl/content/${item.name}.md",
      )),
  ...Apis.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name)
      // url: "$reactJsBaseUrl/content/${item.name}.md",
      )),
  ...Directives.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name)
      // url: "$reactJsBaseUrl/content/${item.name}.md",
      )),
];
