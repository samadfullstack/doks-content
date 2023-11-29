import '../models/models.dart';
import '../models/tech_ids.dart';

RemoteDataList remoteDataList = RemoteDataList(list: [
  reactjsRemoteData,
  tailwindCssData,
  testData,
]);

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/";

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactjs,
  version: 2,
  objUrl: "${TechIds.reactjs}/${TechIds.reactjs}.json",
  pendingDownload: true,
);

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindcss,
  version: 2,
  objUrl: "${TechIds.tailwindcss}/${TechIds.tailwindcss}.json",
  pendingDownload: true,
);

var testData = RemoteDataModel(
  id: TechIds.test,
  version: 2,
  objUrl: "${TechIds.test}/${TechIds.test}.json",
  pendingDownload: true,
);
