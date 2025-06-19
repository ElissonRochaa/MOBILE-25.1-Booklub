import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable()
class BookItem {
  final String? id;

  final String title;

  final String? authors;

  final String? description;

  final String? thumbnail;

  final String? isbn;

  final String? datePublished;

  BookItem({
    this.id,
    required this.title,
    this.authors,
    this.description,
    this.thumbnail,
    this.isbn,
    this.datePublished,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookItemToJson(this);
}
