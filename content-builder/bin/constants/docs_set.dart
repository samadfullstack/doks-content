import '../content/reactjs/docs.dart';
import '../content/test/docs.dart';
import '../models/models.dart';

class DocsSet {
  static String reactjs = DocsListAdapter(docs: reactjsDocs).toJson();
  static String test = DocsListAdapter(docs: testDocs).toJson();
  static String tailwindCss = DocsListAdapter(docs: testDocs).toJson();
}
