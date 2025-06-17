// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookItem _$BookItemFromJson(Map<String, dynamic> json) => BookItem(
  title: json['title'] as String?,
  authors: json['authors'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  isbn: json['isbn'] as String?,
);

Map<String, dynamic> _$BookItemToJson(BookItem instance) => <String, dynamic>{
  'title': instance.title,
  'authors': instance.authors,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'isbn': instance.isbn,
};
