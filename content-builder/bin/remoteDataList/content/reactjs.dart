import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../base_url.dart';

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactJs.name,
  version: 2,
  objUrl: "$baseUrl${TechIds.reactJs.name}/data.json",
  pendingDownload: true,
);
