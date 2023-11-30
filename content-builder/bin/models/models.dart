// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

// * >---------------------------------------> Tech model
class TechModel {
  String id;

  bool isSubTech;
  String techTitle;
  String description;
  String version;
  String downloadSize;
  bool savedOffline;
  List<SectionModel> sectionsList;
  List<String> related;
  TechModel({
    required this.id,
    this.isSubTech = false,
    required this.techTitle,
    required this.description,
    required this.version,
    required this.downloadSize,
    this.savedOffline = false,
    required this.sectionsList,
    required this.related,
  });

  TechModel copyWith({
    String? id,
    bool? isSubTech,
    String? techTitle,
    String? description,
    String? version,
    String? downloadSize,
    bool? savedOffline,
    List<SectionModel>? sectionsList,
    List<String>? related,
  }) {
    return TechModel(
      id: id ?? this.id,
      isSubTech: isSubTech ?? this.isSubTech,
      techTitle: techTitle ?? this.techTitle,
      description: description ?? this.description,
      version: version ?? this.version,
      downloadSize: downloadSize ?? this.downloadSize,
      savedOffline: savedOffline ?? this.savedOffline,
      sectionsList: sectionsList ?? this.sectionsList,
      related: related ?? this.related,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isSubTech': isSubTech,
      'techTitle': techTitle,
      'description': description,
      'version': version,
      'downloadSize': downloadSize,
      'savedOffline': savedOffline,
      'sectionsList': sectionsList.map((x) => x.toMap()).toList(),
      'related': related,
    };
  }

  factory TechModel.fromMap(Map<String, dynamic> map) {
    return TechModel(
      id: map['id'] as String,
      isSubTech: map['isSubTech'] as bool,
      techTitle: map['techTitle'] as String,
      description: map['description'] as String,
      version: map['version'] as String,
      downloadSize: map['downloadSize'] as String,
      savedOffline: map['savedOffline'] as bool,
      sectionsList: List<SectionModel>.from(
        (map['sectionsList'] as List<dynamic>).map<SectionModel>(
          (x) => SectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      related: List<String>.from((map['related'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory TechModel.fromJson(String source) =>
      TechModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TechModel(id: $id, isSubTech: $isSubTech, techTitle: $techTitle, description: $description, version: $version, downloadSize: $downloadSize, savedOffline: $savedOffline, sectionsList: $sectionsList, related: $related)';
  }

  @override
  bool operator ==(covariant TechModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isSubTech == isSubTech &&
        other.techTitle == techTitle &&
        other.description == description &&
        other.version == version &&
        other.downloadSize == downloadSize &&
        other.savedOffline == savedOffline &&
        ListEquality().equals(other.sectionsList, sectionsList) &&
        ListEquality().equals(other.related, related);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isSubTech.hashCode ^
        techTitle.hashCode ^
        description.hashCode ^
        version.hashCode ^
        downloadSize.hashCode ^
        savedOffline.hashCode ^
        sectionsList.hashCode ^
        related.hashCode;
  }
}

// * >---------------------------------------> Section model

class SectionModel {
  String sectionTitle;
  List<DocModel> docList;
  List<SectionModel> subSections;
  SectionModel({
    this.sectionTitle = "",
    this.docList = const [],
    this.subSections = const [],
  });

  SectionModel copyWith({
    String? sectionTitle,
    List<DocModel>? docList,
    List<SectionModel>? subSections,
  }) {
    return SectionModel(
      sectionTitle: sectionTitle ?? this.sectionTitle,
      docList: docList ?? this.docList,
      subSections: subSections ?? this.subSections,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sectionTitle': sectionTitle,
      'docList': docList.map((x) => x.toMap()).toList(),
      'subSections': subSections.map((x) => x.toMap()).toList(),
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      sectionTitle: map['sectionTitle'] as String,
      docList: List<DocModel>.from(
        (map['docList'] as List<dynamic>).map<DocModel>(
          (x) => DocModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      subSections: List<SectionModel>.from(
        (map['subSections'] as List<dynamic>).map<SectionModel>(
          (x) => SectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionModel.fromJson(String source) =>
      SectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SectionModel(sectionTitle: $sectionTitle, docList: $docList, subSections: $subSections)';

  @override
  bool operator ==(covariant SectionModel other) {
    if (identical(this, other)) return true;

    return other.sectionTitle == sectionTitle &&
        ListEquality().equals(other.docList, docList) &&
        ListEquality().equals(other.subSections, subSections);
  }

  @override
  int get hashCode =>
      sectionTitle.hashCode ^ docList.hashCode ^ subSections.hashCode;
}

// * >--------------------------> doc model

class DocModel {
  String? id = Uuid().v1();
  String docTitle;
  String url;
  String markdown;
  List<String> keywords;
  DocModel({
    this.id,
    this.docTitle = "Doc title",
    this.url = "doc url",
    this.markdown = "# markdown",
    this.keywords = const <String>[],
  }) {
    id = Uuid().v1();
  }

  DocModel copyWith({
    String? id,
    String? docTitle,
    String? url,
    String? markdown,
    List<String>? keywords,
  }) {
    return DocModel(
      id: id ?? this.id,
      docTitle: docTitle ?? this.docTitle,
      url: url ?? this.url,
      markdown: markdown ?? this.markdown,
      keywords: keywords ?? this.keywords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'docTitle': docTitle,
      'url': url,
      'markdown': markdown,
      'keywords': keywords,
    };
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id: map['id'] as String,
      docTitle: map['docTitle'] as String,
      url: map['url'] as String,
      markdown: map['markdown'] as String,
      keywords: List<String>.from((map['keywords'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) =>
      DocModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocModel(id: $id, docTitle: $docTitle, url: $url, markdown: $markdown, keywords: $keywords)';
  }

  @override
  bool operator ==(covariant DocModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.docTitle == docTitle &&
        other.url == url &&
        other.markdown == markdown &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        docTitle.hashCode ^
        url.hashCode ^
        markdown.hashCode ^
        keywords.hashCode;
  }
}

class RemoteDataModel {
  String id;
  int version;
  String objUrl;
  bool pendingDownload;
  RemoteDataModel({
    required this.id,
    required this.version,
    required this.objUrl,
    this.pendingDownload = true,
  });

  RemoteDataModel copyWith({
    String? id,
    int? version,
    String? objUrl,
    bool? pendingDownload,
  }) {
    return RemoteDataModel(
      id: id ?? this.id,
      version: version ?? this.version,
      objUrl: objUrl ?? this.objUrl,
      pendingDownload: pendingDownload ?? this.pendingDownload,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'version': version,
      'objUrl': objUrl,
      'pendingDownload': pendingDownload,
    };
  }

  factory RemoteDataModel.fromMap(Map<String, dynamic> map) {
    return RemoteDataModel(
      id: map['id'] as String,
      version: map['version'] as int,
      objUrl: map['objUrl'] as String,
      pendingDownload: map['pendingDownload'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteDataModel.fromJson(String source) =>
      RemoteDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RemoteDataModel(id: $id, version: $version, objUrl: $objUrl, pendingDownload: $pendingDownload)';
  }

  @override
  bool operator ==(covariant RemoteDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.version == version &&
        other.objUrl == objUrl &&
        other.pendingDownload == pendingDownload;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        version.hashCode ^
        objUrl.hashCode ^
        pendingDownload.hashCode;
  }
}

class RemoteDataList {
  List<RemoteDataModel> list;
  RemoteDataList({
    required this.list,
  });

  RemoteDataList copyWith({
    List<RemoteDataModel>? list,
  }) {
    return RemoteDataList(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory RemoteDataList.fromMap(Map<String, dynamic> map) {
    return RemoteDataList(
      list: List<RemoteDataModel>.from(
        (map['list'] as List<dynamic>).map<RemoteDataModel>(
          (x) => RemoteDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteDataList.fromJson(String source) =>
      RemoteDataList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoteDataList(list: $list)';

  @override
  bool operator ==(covariant RemoteDataList other) {
    if (identical(this, other)) return true;

    return ListEquality().equals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}
