import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';

var reactjsRemoteData = RemoteDataModel(
  id: TechIds.reactJs.name,
  version: 2,
  objUrl: MkLink.data(TechIds.reactJs.name),
  // objUrl: "$baseUrl${TechIds.reactJs.name}/data.json",
  pendingDownload: true,
);
