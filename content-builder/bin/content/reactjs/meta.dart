import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';

var reactjsRemoteData = RemoteDataModel(
  version: 2,
  pendingDownload: true,
  id: TechIds.reactJs.name,
  objUrl: MkLink.data(TechIds.reactJs.name),
  // objUrl: "$baseUrl${TechIds.reactJs.name}/data.json",
);
