import 'package:path/path.dart' as pathpkg;

class PathCollection {
  static final String _dataDir = pathpkg.joinAll(
    ["D:", "doks-content", "data"],
  );

  static String remoteDataList = pathpkg.joinAll(
    [_dataDir, "remote_data_list.json"],
  );

  static String reactJs = pathpkg.joinAll(
    [_dataDir, "reactjs.json"],
  );

  static String tailwindCss = pathpkg.joinAll(
    [_dataDir, "tailwindcss.json"],
  );
}
