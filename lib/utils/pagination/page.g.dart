// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => Page<T>(
  content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  pageInfo: PageInfo.fromJson(json['page'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PageToJson<T>(
  Page<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance._content.map(toJsonT).toList(),
  'page': instance.pageInfo,
};

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
  size: (json['size'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
  'size': instance.size,
  'number': instance.number,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
};
