import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';

var tailwindCssData = RemoteDataModel(
  id: TechIds.tailwindCss.name,
  version: 2,
  objUrl: MkLink.data(TechIds.tailwindCss.name),
  pendingDownload: true,
);
