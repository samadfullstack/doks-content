import 'package:path/path.dart' as pathpkg;

class PathCollection {
  static final String _doksContentDataDir = pathpkg.joinAll(
    ["D:", "doks-content", "data"],
  );

  static String remoteDataListJson = pathpkg.joinAll(
    [_doksContentDataDir, "remoteData", "remote_data_list.json"],
  );

  static String reactjsJson = pathpkg.joinAll(
    [_doksContentDataDir, "reactjs", "reactjs.json"],
  );
}
