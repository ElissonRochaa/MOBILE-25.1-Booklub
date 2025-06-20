import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Page<T> {

  final List<T> content;

  @JsonKey(name: 'page')
  final PageInfo pageInfo;

  Page({
    required this.content,
    required this.pageInfo,
  });

  bool get isLastPage => pageInfo.number == pageInfo.totalPages - 1;

  bool get isFirstPage => pageInfo.number == 0;

  bool get hasNextPage => !isLastPage;

  bool get hasPreviousPage => !isFirstPage;

  bool get isEmpty => content.isEmpty;

  List<T> toList() {
    return List.from(content, growable: false);
  }

  factory Page.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT
  ) => _$PageFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T) toJsonT
  ) => _$PageToJson(this, toJsonT);

}

@JsonSerializable()
class PageInfo {

  final int size;

  final int number;

  final int totalElements;

  final int totalPages;

  PageInfo({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

}