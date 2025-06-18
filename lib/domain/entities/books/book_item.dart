import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable()
class BookItem {

  final String? title;

  final String? authors;

  final String? description;

  final String? thumbnail;

  final String? isbn;

  BookItem({
    this.title,
    this.authors,
    this.description,
    this.thumbnail,
    this.isbn,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) => _$BookItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookItemToJson(this);

}
