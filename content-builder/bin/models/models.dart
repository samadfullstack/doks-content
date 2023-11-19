import 'dart:convert';
import 'package:collection/collection.dart';

// * >--------------------------------------------

class TechModel {
  String techTitle;
  String description;
  String version;
  String downloadSize;
  List<SectionModel> sectionsList;
  TechModel({
    required this.techTitle,
    required this.description,
    required this.version,
    required this.downloadSize,
    required this.sectionsList,
  });

  TechModel copyWith({
    String? techTitle,
    String? description,
    String? version,
    String? downloadSize,
    List<SectionModel>? sectionsList,
  }) {
    return TechModel(
      techTitle: techTitle ?? this.techTitle,
      description: description ?? this.description,
      version: version ?? this.version,
      downloadSize: downloadSize ?? this.downloadSize,
      sectionsList: sectionsList ?? this.sectionsList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'techTitle': techTitle,
      'description': description,
      'version': version,
      'downloadSize': downloadSize,
      'sectionsList': sectionsList.map((x) => x.toMap()).toList(),
    };
  }

  factory TechModel.fromMap(Map<String, dynamic> map) {
    return TechModel(
      techTitle: map['techTitle'] as String,
      description: map['description'] as String,
      version: map['version'] as String,
      downloadSize: map['downloadSize'] as String,
      sectionsList: List<SectionModel>.from(
        (map['sectionsList'] as List<int>).map<SectionModel>(
          (x) => SectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TechModel.fromJson(String source) =>
      TechModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TechModel(techTitle: $techTitle, description: $description, version: $version, downloadSize: $downloadSize, sectionsList: $sectionsList)';
  }

  @override
  bool operator ==(covariant TechModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.techTitle == techTitle &&
        other.description == description &&
        other.version == version &&
        other.downloadSize == downloadSize &&
        listEquals(other.sectionsList, sectionsList);
  }

  @override
  int get hashCode {
    return techTitle.hashCode ^
        description.hashCode ^
        version.hashCode ^
        downloadSize.hashCode ^
        sectionsList.hashCode;
  }
}

class SectionModel {
  String sectionTitle;
  List<DocModel> docList;
  SectionModel({
    required this.sectionTitle,
    required this.docList,
  });

  SectionModel copyWith({
    String? sectionTitle,
    List<DocModel>? docList,
  }) {
    return SectionModel(
      sectionTitle: sectionTitle ?? this.sectionTitle,
      docList: docList ?? this.docList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sectionTitle': sectionTitle,
      'docList': docList.map((x) => x.toMap()).toList(),
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      sectionTitle: map['sectionTitle'] as String,
      docList: List<DocModel>.from(
        (map['docList'] as List<int>).map<DocModel>(
          (x) => DocModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionModel.fromJson(String source) =>
      SectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SectionModel(sectionTitle: $sectionTitle, docList: $docList)';

  @override
  bool operator ==(covariant SectionModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.sectionTitle == sectionTitle &&
        listEquals(other.docList, docList);
  }

  @override
  int get hashCode => sectionTitle.hashCode ^ docList.hashCode;
}

// * >--------------------------> doc model
class DocModel {
  String docTitle;
  String url;
  String markdown;
  List<String> keywords;
  DocModel({
    required this.docTitle,
    required this.url,
    required this.markdown,
    required this.keywords,
  });

  DocModel copyWith({
    String? docTitle,
    String? url,
    String? markdown,
    List<String>? keywords,
  }) {
    return DocModel(
      docTitle: docTitle ?? this.docTitle,
      url: url ?? this.url,
      markdown: markdown ?? this.markdown,
      keywords: keywords ?? this.keywords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docTitle': docTitle,
      'url': url,
      'markdown': markdown,
      'keywords': keywords,
    };
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      docTitle: map['docTitle'] as String,
      url: map['url'] as String,
      markdown: map['markdown'] as String,
      keywords: List<String>.from((map['keywords'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) =>
      DocModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocModel(docTitle: $docTitle, url: $url, markdown: $markdown, keywords: $keywords)';
  }

  @override
  bool operator ==(covariant DocModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.docTitle == docTitle &&
        other.url == url &&
        other.markdown == markdown &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return docTitle.hashCode ^
        url.hashCode ^
        markdown.hashCode ^
        keywords.hashCode;
  }
}

class RemoteDataModel {
  String id;
  int version;
  String objUrl;
  bool downloaded;
  RemoteDataModel({
    required this.id,
    required this.version,
    required this.objUrl,
    required this.downloaded,
  });

  RemoteDataModel copyWith({
    String? id,
    int? version,
    String? objUrl,
    bool? downloaded,
  }) {
    return RemoteDataModel(
      id: id ?? this.id,
      version: version ?? this.version,
      objUrl: objUrl ?? this.objUrl,
      downloaded: downloaded ?? this.downloaded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'version': version,
      'objUrl': objUrl,
      'downloaded': downloaded,
    };
  }

  factory RemoteDataModel.fromMap(Map<String, dynamic> map) {
    return RemoteDataModel(
      id: map['id'] as String,
      version: map['version'] as int,
      objUrl: map['objUrl'] as String,
      downloaded: map['downloaded'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteDataModel.fromJson(String source) =>
      RemoteDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RemoteDataModel(id: $id, version: $version, objUrl: $objUrl, downloaded: $downloaded)';
  }

  @override
  bool operator ==(covariant RemoteDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.version == version &&
        other.objUrl == objUrl &&
        other.downloaded == downloaded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        version.hashCode ^
        objUrl.hashCode ^
        downloaded.hashCode;
  }
}

class RemoteDataList {
  List<RemoteDataModel> data;
  RemoteDataList({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory RemoteDataList.fromMap(Map<String, dynamic> map) {
    return RemoteDataList(
      data: List<RemoteDataModel>.from(
        (map['data'] as List<int>).map<RemoteDataModel>(
          (x) => RemoteDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteDataList.fromJson(String source) =>
      RemoteDataList.fromMap(json.decode(source) as Map<String, dynamic>);

  RemoteDataList copyWith({
    List<RemoteDataModel>? data,
  }) {
    return RemoteDataList(
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'RemoteDataList(data: $data)';

  @override
  int get hashCode => data.hashCode;
}
