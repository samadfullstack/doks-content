import '../models/models.dart';
import '../models/tech_ids.dart';

List<RemoteDataModel> remoteDataList = [reactjsRemoteData];

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactjs,
  version: 0,
  objUrl:
      "https://raw.githubusercontent.com/samadfullstack/doks-content/master/data/reactjs.json",
  downloaded: false,
);
