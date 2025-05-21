import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/profile/widgets/activity_card_builder.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubActivitiesListWidget extends StatefulWidget {

  const ClubActivitiesListWidget({super.key});

  @override
  State<ClubActivitiesListWidget> createState() => _ClubActivitiesListWidgetState();
}

class _ClubActivitiesListWidgetState extends State<ClubActivitiesListWidget> {

  ClubActivityCategory? activitiesCategory = ClubActivityCategory.readings;

  Paginator<ClubActivity>? paginator;

  @override
  Widget build(BuildContext context) {
    final clubProfilePageViewModel = context.watch<ClubProfileViewModel>();

    final Future<Paginator<ClubActivity>> futureClubActivities;
    switch (activitiesCategory) {
      case null:
        futureClubActivities = clubProfilePageViewModel
          .findClubActivities('1', 2);
      case _:
        futureClubActivities = clubProfilePageViewModel
          .findClubActivities('1', 2, activitiesCategory);
    }

    return MultiSliver(
      children: [
        Builder(builder: _buildClubActivityTypeSelector),
        AsyncBuilder(
          future: futureClubActivities,
          onRetrieved: (paginator) {
            this.paginator = paginator;
            return Builder(builder: _buildActivitiesInfiniteScroll);
          },
          onLoading: () => Builder(builder: _buildSessionLoading),
          onError: (_, _) => Builder(builder: _buildSessionError),
        ),
      ],
    );
  }

  Widget _buildClubActivityTypeSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final sections = [
      SectionSelectorItem(
        label: 'Recentes',
        onSelect: () => setState(() => activitiesCategory = null),
        isSelected: activitiesCategory == null,
      ),
      SectionSelectorItem(
        label: 'Leituras',
        onSelect: () => setState(() => activitiesCategory = ClubActivityCategory.readings),
        isSelected: activitiesCategory == ClubActivityCategory.readings,
      ),
      SectionSelectorItem(
        label: 'Encontros',
        onSelect: () => setState(() => activitiesCategory = ClubActivityCategory.meetings),
        isSelected: activitiesCategory == ClubActivityCategory.meetings,
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

  Widget _buildSessionLoading(BuildContext context) => SliverFillRemaining(
    hasScrollBody: false,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget _buildSessionError(BuildContext context) => SliverFillRemaining(
    child: Center(
      child: Text('Não foi possível acessar as atividades do clube'),
    ),
  );

  Widget _buildActivitiesInfiniteScroll(BuildContext context) {
    final scrollController = context.watch<ScrollController>();

    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisSpacing: 12,
      childAspectRatio: 5/2
    );

    SliverChildBuilderDelegate childrenDelegateProvider(
      List<ClubActivity> itens,
      int totalItens,
    ) => SliverChildBuilderDelegate(
      (context, index) => ActivityCardBuilder(clubActivity: itens[index]),
      childCount: totalItens,
    );


    final infiniteScroll = InfiniteGridWidget.sliver(
      paginator: paginator!,
      controller: scrollController,
      gridDelegate: gridDelegate,
      childrenDelegateProvider: childrenDelegateProvider
    );

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 36
      ),
      sliver: infiniteScroll,
    );
  }

}