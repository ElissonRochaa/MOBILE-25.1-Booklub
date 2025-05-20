import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:sliver_tools/sliver_tools.dart';

class InfiniteGridWidget<T> extends StatefulWidget {

  final bool isSliver;

  final Paginator<T> paginator;

  final ScrollController controller;

  final SliverGridDelegate gridDelegate;

  final SliverChildBuilderDelegate
    Function(List<T> itens, int totalItens) childrenDelegateProvider;

  const InfiniteGridWidget({
    super.key,
    required this.paginator,
    required this.controller,
    required this.gridDelegate,
    required this.childrenDelegateProvider,
  }): isSliver = false;

  const InfiniteGridWidget.sliver({
    super.key,
    required this.paginator,
    required this.controller,
    required this.gridDelegate,
    required this.childrenDelegateProvider,
  }): isSliver = true;

  @override
  State<InfiniteGridWidget<T>> createState() => _InfiniteGridWidgetState<T>();

}

class _InfiniteGridWidgetState<T> extends State<InfiniteGridWidget<T>> {

  final List<T> _items = [];

  int _currentPage = 0;

  bool _isLoading = false;

  bool get _hasMore => _currentPage < widget.paginator.totalPages;

  bool get isScrollable {
    final maxScrollExtent = widget.controller.position.maxScrollExtent;
    final viewPortExtent = widget.controller.position.viewportDimension;

    return maxScrollExtent > viewPortExtent;
  }

  Future<void> _fetchNextPage() async {
    setState(() => _isLoading = true);

    try {
      final nextPage = await widget.paginator[_currentPage];
      _items.addAll(nextPage.toList());
      _currentPage++;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
    _fetchNextPage();
  }

  @override
  Widget build(BuildContext context) => widget.isSliver
    ? _buildSliverPaginatedGridWidget()
    : _buildPaginatedGridWidget();

  void _onScroll() {
    final preloadOffset = widget.controller.position.maxScrollExtent - 200;
    final scrollPosition = widget.controller.position.pixels;
    if (
      scrollPosition >= preloadOffset
      && !_isLoading
      && _hasMore
    ) {
      _fetchNextPage();
    }
  }

  Widget _buildPaginatedGridWidget() {
    if (_hasMore && !_isLoading && !isScrollable) _fetchNextPage();

    return Column(
      children: [
        Expanded(
          child: GridView.custom(
            controller: widget.controller,
            gridDelegate: widget.gridDelegate,
            childrenDelegate: widget.childrenDelegateProvider(_items, _items.length),
          ),
        ),
        if (_isLoading) const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget _buildSliverPaginatedGridWidget() {
    if (_hasMore && !_isLoading && !isScrollable) _fetchNextPage();

    return MultiSliver(
      children: [
        SliverGrid(
          gridDelegate: widget.gridDelegate,
          delegate: widget.childrenDelegateProvider(_items, _items.length),
        ),
        if (_isLoading) const SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ]
    );
  }

}
