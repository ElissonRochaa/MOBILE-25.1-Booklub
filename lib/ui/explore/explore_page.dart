import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/widgets/cards/books/horizontal_book_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/clubs/horizontal_club_card_widget.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/ui/explore/view_model/explore_view_model.dart';
import 'package:booklub/ui/explore/widget/search_bar_widget.dart';
import 'package:booklub/ui/explore/widget/user_horizontal_card_widget.dart';
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
  ExploreSection section = ExploreSection.clubs;
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
        decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest),
        child: SectionSelectorWidget(sections: sections),
      ),
    );
  }

  Widget _buildCardsList(BuildContext context) {
    final exploreViewModel = context.watch<ExploreViewModel>();
    final scrollController = context.read<ScrollController>();

    final query = context.watch<SearchQueryNotifier>().query;

    Widget itemsList;

    switch (section) {
      case ExploreSection.all:
        final futurePaginator = exploreViewModel.findAllWithNameContaining(
          query,
          8,
        );

        itemsList = _handleFutureEntityList(
          futurePaginator,
          scrollController,
          (item) =>
              item is User
                  ? UserHorizontalCardWidget(user: item)
                  : item is Club
                  ? HorizontalClubCardWidget(club: item)
                  : item is BookItem
                  ? HorizontalBookCardWidget(
                    book: item,
                  ) //isso aqui tá feio pra krl mas por enquanto ta funcionando
                  : SizedBox.shrink(),
        );

        break;
      case ExploreSection.books:
        Future<Paginator<BookItem>> futurePaginator = exploreViewModel
            .findBooksByTitleContaining(query, 8);
        itemsList = _handleFutureEntityList(
          futurePaginator,
          scrollController,
          (book) => HorizontalBookCardWidget(book: book),
        );
        break;

      case ExploreSection.clubs:
        Future<Paginator<Club>> futurePaginator = exploreViewModel
            .searchClubByName(query, 8);
        itemsList = _handleFutureEntityList(
          futurePaginator,
          scrollController,
          (club) => HorizontalClubCardWidget(club: club),
        );
        break;
      case ExploreSection.readers:
        Future<Paginator<User>> futurePaginator = exploreViewModel
            .findByUsernameContaining(query, 8);
        itemsList = _handleFutureEntityList(
          futurePaginator,
          scrollController,
          (user) => UserHorizontalCardWidget(user: user),
        );
        break;
    }

    return SliverPadding(
      padding: EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 36),
      sliver: itemsList,
    );
  }

  Widget _handleFutureEntityList<T>(
    Future<Paginator<T>> futurePaginator,
    ScrollController scrollController,
    Widget Function(T item) cardWidgetBuilder,
  ) {
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 7 / 2,
      mainAxisSpacing: 12,
    );

    SliverChildBuilderDelegate childrenDelegateProvider(
      List<T> items,
      int totalItems,
    ) => SliverChildBuilderDelegate(
      (context, index) => cardWidgetBuilder(items[index]),
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
      onError: (e, trace) {
        print('Error: $e \n Trace: $trace');
        return Builder(builder: _buildErrorPage);
      },
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
