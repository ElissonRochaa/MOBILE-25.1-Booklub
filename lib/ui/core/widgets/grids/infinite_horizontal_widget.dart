import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart' hide Page;

class InfiniteHorizontalList<T> extends StatefulWidget {
  final Paginator<T> paginator;
  final Widget Function(T item) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;

  const InfiniteHorizontalList({
    super.key,
    required this.paginator,
    required this.itemBuilder,
    this.controller,
    this.padding,
  });

  @override
  State<InfiniteHorizontalList<T>> createState() => _InfiniteHorizontalListState<T>();
}

class _InfiniteHorizontalListState<T> extends State<InfiniteHorizontalList<T>> {
  final List<T> _items = [];
  int _currentPage = 0;
  bool _isLoading = false;

  late final ScrollController _scrollController;

  bool get _hasMore => _currentPage < widget.paginator.totalPages;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchNextPage();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMore) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      final page = await widget.paginator[_currentPage];
      setState(() {
        _items.addAll(page.toList());
        _currentPage++;
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _items.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _items.length) {
            return widget.itemBuilder(_items[index]);
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
