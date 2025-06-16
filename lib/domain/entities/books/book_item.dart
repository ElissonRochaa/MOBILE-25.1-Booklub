import 'package:flutter/widgets.dart';

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

  // a api vai me mandar um json com um mapa chave-valor.
  // o dart vai receber como um map e a factory fromJson vai converter esse mapa ao criar um bookItem usando os valores do mapa json.

  // o construtor normal é quando monta do 0. o factory já sabe como vai montar a partir do que recebe (algo diferente).

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      title: json['title'],
      authors: json['authors'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      isbn: json['isbn'],
    );
  }
}
