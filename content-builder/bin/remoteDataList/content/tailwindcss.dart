import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../base_url.dart';

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindCss.name,
  version: 2,
  objUrl: "$baseUrl${TechIds.tailwindCss.name}/data.json",
  pendingDownload: true,
);
