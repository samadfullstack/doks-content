// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

// * >---------------------------------------> Tech model
listEquals(list1, list2) => ListEquality().equals(list1, list2);

class TechModel {
  String id;

  bool isSubTech;
  String techTitle;
  String description;
  String version;
  String downloadSize;
  bool saved;
  List<SectionModel> sectionsList;
  List<String> related;
  String docsUrl;
  TechModel({
    required this.id,
    this.saved = false,
    this.isSubTech = false,
    required this.techTitle,
    required this.description,
    required this.version,
    required this.downloadSize,
    required this.sectionsList,
    required this.related,
    required this.docsUrl,
  });

  TechModel copyWith({
    String? id,
    bool? isSubTech,
    String? techTitle,
    String? description,
    String? version,
    String? downloadSize,
    bool? saved,
    List<SectionModel>? sectionsList,
    List<String>? related,
    String? docsUrl,
  }) {
    return TechModel(
      id: id ?? this.id,
      isSubTech: isSubTech ?? this.isSubTech,
      techTitle: techTitle ?? this.techTitle,
      description: description ?? this.description,
      version: version ?? this.version,
      downloadSize: downloadSize ?? this.downloadSize,
      saved: saved ?? this.saved,
      sectionsList: sectionsList ?? this.sectionsList,
      related: related ?? this.related,
      docsUrl: docsUrl ?? this.docsUrl,
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
      'saved': saved,
      'sectionsList': sectionsList.map((x) => x.toMap()).toList(),
      'related': related,
      'docsUrl': docsUrl,
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
      saved: map['saved'] as bool,
      sectionsList: List<SectionModel>.from(
        (map['sectionsList'] as List<int>).map<SectionModel>(
          (x) => SectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      related: List<String>.from((map['related'] as List)),
      docsUrl: map['docsUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TechModel.fromJson(String source) =>
      TechModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TechModel(id: $id, isSubTech: $isSubTech, techTitle: $techTitle, description: $description, version: $version, downloadSize: $downloadSize, saved: $saved, sectionsList: $sectionsList, related: $related, docsUrl: $docsUrl)';
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
        other.saved == saved &&
        listEquals(other.sectionsList, sectionsList) &&
        listEquals(other.related, related) &&
        other.docsUrl == docsUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isSubTech.hashCode ^
        techTitle.hashCode ^
        description.hashCode ^
        version.hashCode ^
        downloadSize.hashCode ^
        saved.hashCode ^
        sectionsList.hashCode ^
        related.hashCode ^
        docsUrl.hashCode;
  }
}

// * >---------------------------------------> Section model

class SectionModel {
  String sectionTitle;
  List<String> docList;
  List<SectionModel> subSections;
  SectionModel({
    this.sectionTitle = "",
    this.docList = const [],
    this.subSections = const [],
  });

  SectionModel copyWith({
    String? sectionTitle,
    List<String>? docList,
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
      'docList': docList,
      'subSections': subSections.map((x) => x.toMap()).toList(),
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      sectionTitle: map['sectionTitle'] as String,
      docList: List<String>.from((map['docList'] as List)),
      subSections: List<SectionModel>.from(
        (map['subSections'] as List<int>).map<SectionModel>(
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
        listEquals(other.docList, docList) &&
        listEquals(other.subSections, subSections);
  }

  @override
  int get hashCode =>
      sectionTitle.hashCode ^ docList.hashCode ^ subSections.hashCode;
}

// * >--------------------------> doc model

class DocModel {
  String id;
  bool saved;
  String docTitle;
  String url;
  String markdown;
  List<String> keywords;
  DocModel({
    this.saved = false,
    this.id = "",
    this.docTitle = "",
    this.url = "",
    this.markdown = "",
    this.keywords = const [],
  });

  DocModel copyWith({
    String? id,
    bool? saved,
    String? docTitle,
    String? url,
    String? markdown,
    List<String>? keywords,
  }) {
    return DocModel(
      id: id ?? this.id,
      saved: saved ?? this.saved,
      docTitle: docTitle ?? this.docTitle,
      url: url ?? this.url,
      markdown: markdown ?? this.markdown,
      keywords: keywords ?? this.keywords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'saved': saved,
      'docTitle': docTitle,
      'url': url,
      'markdown': markdown,
      'keywords': keywords,
    };
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id: map['id'] as String,
      saved: map['saved'] as bool,
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
    return 'DocModel(id: $id, saved: $saved, docTitle: $docTitle, url: $url, markdown: $markdown, keywords: $keywords)';
  }

  @override
  bool operator ==(covariant DocModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.saved == saved &&
        other.docTitle == docTitle &&
        other.url == url &&
        other.markdown == markdown &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        saved.hashCode ^
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

class RemoteDataListAdapter {
  List<RemoteDataModel> list;
  RemoteDataListAdapter({
    required this.list,
  });

  RemoteDataListAdapter copyWith({
    List<RemoteDataModel>? list,
  }) {
    return RemoteDataListAdapter(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory RemoteDataListAdapter.fromMap(Map<String, dynamic> map) {
    return RemoteDataListAdapter(
      list: List<RemoteDataModel>.from(
        (map['list'] as List<dynamic>).map<RemoteDataModel>(
          (x) => RemoteDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteDataListAdapter.fromJson(String source) =>
      RemoteDataListAdapter.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoteDataList(list: $list)';

  @override
  bool operator ==(covariant RemoteDataListAdapter other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}

class DocsListAdapter {
  List<DocModel> docs;
  DocsListAdapter({
    required this.docs,
  });

  DocsListAdapter copyWith({
    List<DocModel>? docs,
  }) {
    return DocsListAdapter(
      docs: docs ?? this.docs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docs': docs.map((x) => x.toMap()).toList(),
    };
  }

  factory DocsListAdapter.fromMap(Map<String, dynamic> map) {
    return DocsListAdapter(
      docs: List<DocModel>.from(
        (map['docs'] as List<int>).map<DocModel>(
          (x) => DocModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocsListAdapter.fromJson(String source) =>
      DocsListAdapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DocsListAdapter(docs: $docs)';

  @override
  bool operator ==(covariant DocsListAdapter other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.docs, docs);
  }

  @override
  int get hashCode => docs.hashCode;
}
