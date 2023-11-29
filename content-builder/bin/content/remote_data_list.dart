import '../models/models.dart';
import '../models/tech_ids.dart';

RemoteDataList remoteDataList = RemoteDataList(list: [
  reactjsRemoteData,
  tailwindCssData,
  testData,
]);

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactjs,
  version: 2,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/reactjs.json",
  pendingDownload: true,
);

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindcss,
  version: 2,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/tailwindcss.json",
  pendingDownload: true,
);

var testData = RemoteDataModel(
  id: TechIds.test,
  version: 2,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/test.json",
  pendingDownload: true,
);
