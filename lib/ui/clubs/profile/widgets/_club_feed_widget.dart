import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_meeting_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_reading_goal_card_widget.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum _FeedSection {activities, readingGoals, meetings}

class ClubFeedWidget extends StatefulWidget {

  const ClubFeedWidget({super.key});

  @override
  State<ClubFeedWidget> createState() => _ClubFeedWidgetState();

}

class _ClubFeedWidgetState extends State<ClubFeedWidget> {

  final logger = Logger();

  _FeedSection section = _FeedSection.activities;

  Paginator<ClubActivity>? paginator;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        Builder(builder: _buildFeedSectionSelector),
        switch (section) {
          _FeedSection.activities => Placeholder(),
          _FeedSection.readingGoals => _buildReadingGoalsList(),
          _FeedSection.meetings => _buildMeetingsList(),
        },
      ],
    );
  }

  Widget _buildFeedSectionSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final sections = [
      SectionSelectorItem(
        label: 'Atividades',
        onSelect: () => setState(() => section = _FeedSection.activities),
        isSelected: section == _FeedSection.activities,
      ),
      SectionSelectorItem(
        label: 'Leituras',
        onSelect: () => setState(() => section = _FeedSection.readingGoals),
        isSelected: section == _FeedSection.readingGoals,
      ),
      SectionSelectorItem(
        label: 'Encontros',
        onSelect: () => setState(() => section = _FeedSection.meetings),
        isSelected: section == _FeedSection.meetings,
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.white,
          boxShadow: [BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 4
          )]
        ),
        padding: EdgeInsets.symmetric(vertical: 6),
        child: SectionSelectorWidget(
          sections: sections,
          spacing: 8,
        ),
      ),
    );
  }

  Widget _buildReadingGoalsList() {
    final viewModel = context.read<ClubProfileViewModel>();

    return AsyncBuilder(
      future: viewModel.getClubReadingGoals(10),
      onRetrieved: (paginator) => Builder(
        builder: (context) => _buildList(
          context,
          paginator,
          (item) => HorizontalReadingGoalCardWidget(
            readingGoal: item,
            club: viewModel.club!,
            bookItem: BookItem(), // TODO Implementar busca por livro
          ),
        )
      ),
      onLoading: () => Builder(builder: _buildOnLoadingList),
      onError: (e, trace) => Builder(
        builder: (context) => _buildOnErrorList(
          context,
          'Erro ao buscar leituras',
          e,
          trace
        )
      )
    );
  }

  Widget _buildMeetingsList() {
    final viewModel = context.read<ClubProfileViewModel>();

    return AsyncBuilder(
      future: viewModel.getClubMeetings(10),
      onRetrieved: (paginator) => Builder(
        builder: (context) => _buildList(
          context,
        paginator,
          (item) => HorizontalMeetingCardWidget(
          meeting: item,
          club: viewModel.club!,
          book: BookItem(title: 'O Mundo de Sopheia'), // TODO Implementar busca por livro
          ),
        )
      ),
      onLoading: () => Builder(builder: _buildOnLoadingList),
      onError: (e, trace) => Builder(
        builder: (context) => _buildOnErrorList(
          context,
          'Erro ao buscar encontros',
          e,
          trace
        )
      )
    );
  }

  Widget _buildList<T>(
    BuildContext context,
    Paginator<T> paginator,
    Widget Function(T item) itemBuilder,
  ) {
    final controller = context.read<ScrollController>();

    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisSpacing: 12,
      childAspectRatio: 4/2
    );

    SliverChildBuilderDelegate childrenDelegateProvider(List<T> itens, int total) {
      return SliverChildBuilderDelegate(
        (context, index) => itemBuilder(itens[index]),
        childCount: itens.length,
      );
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 36
      ),
      sliver: InfiniteGridWidget.sliver(
        paginator: paginator,
        controller: controller,
        gridDelegate: gridDelegate,
        childrenDelegateProvider: childrenDelegateProvider,
      ),
    );
  }

  Widget _buildOnLoadingList(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildOnErrorList(
    BuildContext context,
    String message,
    Object error,
    StackTrace stackTrace
  ) {
    logger.e('Error: $error \n Stack Trace: $stackTrace');

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(message),
      ),
    );
  }

}