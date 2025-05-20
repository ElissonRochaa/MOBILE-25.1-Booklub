import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/ui/core/widgets/section_selector_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum ClubActivity {recentes, leituras, encontros}

class ClubActivitiesListWidget extends StatefulWidget {

  final ScrollController scrollController;

  const ClubActivitiesListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  State<ClubActivitiesListWidget> createState() => _ClubActivitiesListWidgetState();
}

class _ClubActivitiesListWidgetState extends State<ClubActivitiesListWidget> {

  ClubActivity activity = ClubActivity.leituras;

  @override
  Widget build(BuildContext context) {
    final clubProfilePageViewModel = context.watch<ClubProfileViewModel>();

    return MultiSliver(
      children: [
        Builder(builder: _buildClubActivityTypeSelector),
        AsyncBuilder(
          future: clubProfilePageViewModel.findClubs(2),
          onRetrieved: (paginator) => Builder(
            builder: (context) => _buildActivitiesInfiniteScroll(
              context: context,
              paginator: paginator
            )
          ),
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
        onSelect: () => setState(() => activity = ClubActivity.recentes),
        isSelected: activity == ClubActivity.recentes,
      ),
      SectionSelectorItem(
        label: 'Leituras',
        onSelect: () => setState(() => activity = ClubActivity.leituras),
        isSelected: activity == ClubActivity.leituras,
      ),
      SectionSelectorItem(
        label: 'Encontros',
        onSelect: () => setState(() => activity = ClubActivity.encontros),
        isSelected: activity == ClubActivity.encontros,
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

  Widget _buildActivitiesInfiniteScroll<T>({
    required BuildContext context,
    required Paginator<T> paginator,
  }) {
    final infiniteScroll = InfiniteGridWidget.sliver(
      paginator: paginator,
      controller: widget.scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
        childAspectRatio: 5/2,
      ),
      childrenDelegateProvider: (itens, totalItens) => (
        SliverChildBuilderDelegate(
          (context, index) => Placeholder(),
          childCount: totalItens,
        )
      ),
    );

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 32
      ),
      sliver: infiniteScroll,
    );
  }

}