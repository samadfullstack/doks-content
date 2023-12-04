import '../../constants/tech_ids.dart';
import '../../models/models.dart';
import '../../utils/link_maker.dart';

var testData = MetaData(
  id: TechIds.test.name,
  version: 2,
  objUrl: MkLink.data(TechIds.test.name),
  downloaded: true,
);
