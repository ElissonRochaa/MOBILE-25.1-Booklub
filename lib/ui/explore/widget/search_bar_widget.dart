import 'package:flutter/material.dart';

class SearchQueryNotifier extends ChangeNotifier {
  String _query = ' ';

  String get query => _query;

  void update(String newQuery) {
    _query = newQuery;

    if(newQuery == '') {
      _query = ' ';
    }
    notifyListeners();
  }
}
