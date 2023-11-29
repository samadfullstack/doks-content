import '../models/models.dart';
import '../constants/tech_ids.dart';

RemoteDataList remoteDataList = RemoteDataList(list: [
  reactjsRemoteData,
  tailwindCssData,
  testData,
]);

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/";

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactJs.name,
  version: 2,
  objUrl: "$_baseUrl${TechIds.reactJs.name}/data.json",
  pendingDownload: true,
);

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindCss.name,
  version: 2,
  objUrl: "$_baseUrl${TechIds.tailwindCss.name}/data.json",
  pendingDownload: true,
);

var testData = RemoteDataModel(
  id: TechIds.test.name,
  version: 2,
  objUrl: "$_baseUrl${TechIds.test.name}/data.json",
  pendingDownload: true,
);
