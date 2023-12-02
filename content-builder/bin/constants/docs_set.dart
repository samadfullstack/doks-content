import '../content/reactjs/docs.dart';
import '../content/test/docs.dart';
import '../models/models.dart';

class DocsSet {
  static String reactjs = DocsListAdapter(list: reactjsDocs).toJson();
  static String test = DocsListAdapter(list: testDocs).toJson();
  static String tailwindCss = DocsListAdapter(list: testDocs).toJson();
}
