import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/clubs/view_models/clubs_view_model.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_club_card_widget.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum ClubsPageSection {participating, managed}

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key, required this.title});

  final String title;

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {

  ClubsPageSection section = ClubsPageSection.participating;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        Builder(builder: _buildClubsPageSectionSelector),
        Builder(builder: _buildClubsList)
      ],
    );
  }

  Widget _buildClubsPageSectionSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final sections = [
      SectionSelectorItem(
        label: 'Participando',
        onSelect: () => setState(() => section = ClubsPageSection.participating),
        isSelected: section == ClubsPageSection.participating
      ),
      SectionSelectorItem(
        label: 'Administrados',
        onSelect: () => setState(() => section = ClubsPageSection.managed),
        isSelected: section == ClubsPageSection.managed
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: colorScheme.white),
        child: SectionSelector(sections: sections)
      )
    );
  }

  Widget _buildClubsList(BuildContext context) {
    final clubsViewModel = context.watch<ClubsViewModel>();
    final scrollController = context.read<ScrollController>();
    final clubs = section == ClubsPageSection.participating
      ? clubsViewModel.findMyClubs(4)
      : clubsViewModel.findManagedClubs(4);

    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 7/2,
      mainAxisSpacing: 12
    );

    SliverChildBuilderDelegate childrenDelegateProvider(
      List<Club> clubs,
      int totalClubs
    ) => SliverChildBuilderDelegate(
      (context, index) => HorizontalClubCardWidget(club: clubs[index]),
      childCount: totalClubs,
    );

    final clubsList = AsyncBuilder(
      future: clubs,
      onRetrieved: (paginator) => InfiniteGridWidget.sliver(
        paginator: paginator,
        controller: scrollController,
        gridDelegate: gridDelegate,
        childrenDelegateProvider: childrenDelegateProvider
      ),
      onLoading: () => Builder(builder: _buildLoadingPage),
      onError: (_, _) => Builder(builder: _buildErrorPage),
    );

    return SliverPadding(
      padding: EdgeInsets.only(
        right: 12,
        left: 12,
        top: 12,
        bottom: 36,
      ),
      sliver: clubsList,
    );
  }

  Widget _buildLoadingPage(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator()
        ]
      ),
    );
  }

  Widget _buildErrorPage(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final errorMessage = 'Falha ao carregar clubes';

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: textTheme.titleSmall!.copyWith(
                color: colorScheme.error
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ),
      ),
    );
  }

}