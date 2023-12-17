import '../models/models.dart';

abstract class AbstractTechData {
  /// a unique prefix that will be used to find this tech. this will be used as tech id
  String get id;

  /// this data will be used to build sections in this tech doc
  TechModel get data;

  /// files that are used in this tech
  List<String> get fileNames;

  /// version of this techData
  /// on each change in content of this tech, increment this number
  /// this way we update this tech in isardb in doks
  int get version;
}
