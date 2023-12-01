import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../base_url.dart';

var testData = RemoteDataModel(
  id: TechIds.test.name,
  version: 2,
  objUrl: "$baseUrl${TechIds.test.name}/data.json",
  pendingDownload: true,
);
