import '../content/reactjs/docs.dart';
import '../models/models.dart';

class DocsSet {
  static String reactjs = DocsListAdapter(list: reactjsDocs).toJson();
}
