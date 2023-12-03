import '../models/models.dart';
import '../content/reactjs/meta.dart';
import '../content/tailwindcss/meta.dart';
import '../content/test/meta.dart';

RemoteDataListAdapter remoteDataList = RemoteDataListAdapter(
  list: [
    reactjsRemoteData,
    tailwindCssData,
    testData,
  ],
);
