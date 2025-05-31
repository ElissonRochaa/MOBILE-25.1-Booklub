import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/widgets/grids/base_grid_widget.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/ui/explore/layout/user_horizontal_card_widget.dart';
import 'package:booklub/ui/explore/layout/view_model/search_bar_widget.dart';
import 'package:booklub/ui/explore/view_model/explore_view_model.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum ExploreSection { all, clubs, books, readers }

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ExploreSection section = ExploreSection.readers;
  @override
  Widget build(BuildContext context) {

    return MultiSliver(
      children: [
        Builder(builder: _buildClubsPageSectionSelector),
        Builder(builder: _buildCardsList),
      ],
    );
  }

  Widget _buildClubsPageSectionSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final sections = [
      SectionSelectorItem(
        label: 'Tudo',
        onSelect: () => setState(() => section = ExploreSection.all),
        isSelected: section == ExploreSection.all,
      ),
      SectionSelectorItem(
        label: 'Clubes',
        onSelect: () => setState(() => section = ExploreSection.clubs),
        isSelected: section == ExploreSection.clubs,
      ),
      SectionSelectorItem(
        label: 'Livros',
        onSelect: () => setState(() => section = ExploreSection.books),
        isSelected: section == ExploreSection.books,
      ),
      SectionSelectorItem(
        label: 'Leitores',
        onSelect: () => setState(() => section = ExploreSection.readers),
        isSelected: section == ExploreSection.readers,
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: colorScheme.white),
        child: SectionSelectorWidget(sections: sections),
      ),
    );
  }

  Widget _buildCardsList(BuildContext context) {
    final exploreViewModel = context.watch<ExploreViewModel>();
    final scrollController = context.read<ScrollController>();

    final query = context.watch<SearchQueryNotifier>().query;

    var itemsList;  

    switch (section) {
      case ExploreSection.all:
        Future<Paginator<User>> futurePaginator = exploreViewModel.findAllWithNameContaining(query, 8);
        itemsList = _handleFutureUserList(futurePaginator, scrollController);
        break;
      case ExploreSection.books:
        Future<Paginator<User>> futurePaginator = exploreViewModel.findBooksByTitleContaining(query, 8);
        itemsList = _handleFutureUserList(futurePaginator, scrollController);
        break;
      case ExploreSection.clubs:
        Future<Paginator<User>> futurePaginator = exploreViewModel.findClubByTitleContaining(query, 8);
        itemsList = _handleFutureUserList(futurePaginator, scrollController);
        break;
      case ExploreSection.readers:
        Future<Paginator<User>> futurePaginator = exploreViewModel.findByUsernameContaining(query, 8);
        itemsList = _handleFutureUserList(futurePaginator, scrollController);
        break;
    }

    return SliverPadding(
      padding: EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 36),
      sliver: itemsList,
    );
  }

  Widget _handleFutureUserList(
    Future<Paginator<User>> futurePaginator,
    ScrollController scrollController,
  ) {
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 7 / 2,
      mainAxisSpacing: 12,
    );

    SliverChildBuilderDelegate childrenDelegateProvider(
      List<User> items,
      int totalItems,
    ) => SliverChildBuilderDelegate(
      (context, index) => UserHorizontalCardWidget(user: items[index]),
      childCount: totalItems,
    );

    return AsyncBuilder(
      future: futurePaginator,
      onRetrieved:
          (paginator) => InfiniteGridWidget.sliver(
            paginator: paginator,
            controller: scrollController,
            gridDelegate: gridDelegate,
            childrenDelegateProvider: childrenDelegateProvider,
          ),
      onLoading: () => Builder(builder: _buildLoadingPage),
      onError: (_, __) => Builder(builder: _buildErrorPage),
    );
  }

  Widget _buildLoadingPage(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }

  Widget _buildErrorPage(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final errorMessage = 'Falha ao carregar página';

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: textTheme.titleSmall!.copyWith(color: colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}
