import '../models/models.dart';
import '../models/tech_ids.dart';

RemoteDataList remoteDataList = RemoteDataList(data: [
  reactjsRemoteData,
  tailwindCssData,
]);

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactjs,
  version: 0,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/reactjs.json",
  downloaded: false,
);

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindcss,
  version: 0,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/tailwindcss.json",
  downloaded: false,
);
