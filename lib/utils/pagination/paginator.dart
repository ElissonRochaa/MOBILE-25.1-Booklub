import 'package:booklub/utils/pagination/page.dart';

class Paginator<T> {

  final Map<int, Page<T>> _pages = {};

  final int pageSize;

  final Future<Page<T>> Function(int page, int pageSize) pageRetriever;

  late final int totalElements;

  late final int totalPages;

  Paginator._(this.pageSize, this.pageRetriever);

  static Future<Paginator<T>> create<T>(
    int pageSize,
    Future<Page<T>> Function(int page, int pageSize) pageRetriever
  ) async {
    final paginator = Paginator._(pageSize, pageRetriever);
    final firstPage = await pageRetriever(0, pageSize);
    paginator.totalElements = firstPage.pageInfo.totalElements;
    paginator.totalPages = firstPage.pageInfo.totalPages;
    return paginator;
  }

  Future<Page<T>> operator [](int index) async {
    if (_pages.containsKey(index)) return _pages[index]!;
    final newPage = await pageRetriever(index, pageSize);
    _pages[index] = newPage;
    return newPage;
  }

}
