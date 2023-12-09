import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';
import '../reactjs/ids.dart';

List<DocModel> testDocs = [
  ...Images.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.test.name, item.name))),
  ...Hooks.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name))),
  ...Components.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name))),
  ...Apis.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name))),
  ...Directives.values.map((item) => DocModel(
      docTitle: item.name,
      id: item.prefix,
      url: MkLink.content(TechIds.reactJs.name, item.name))),
];
