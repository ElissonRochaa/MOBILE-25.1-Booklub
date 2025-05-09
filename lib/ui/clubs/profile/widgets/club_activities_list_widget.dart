import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/profile/widgets/activity_card.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
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

  void setSession(ClubActivity session) => setState(
    () => activity = session);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final clubProfilePageViewModel = context.watch<ClubProfileViewModel>();

    return MultiSliver(
      children: [
        _buildSessionSelector(context),
        AsyncBuilder(
          future: clubProfilePageViewModel.findClubs(3),
          onRetrieved: (paginator) => _buildActivitiesInfiniteScroll(
            paginator: paginator,
            colorScheme: colorScheme,
            textTheme: textTheme
          ),
          onLoading: () => _buildSessionLoadingWidget(),
          onError: (_, _) => _buildSessionErrorWidget()
        ),
      ],
    );
  }

  Widget _buildSessionSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget addButton() => Container(
      decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle
      ),
      child: IconButton(
          color: colorScheme.onPrimary,
          onPressed: () {},
          icon: Icon(Icons.add_rounded)
      ),
    );

    final sessionSelector = SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 0,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 6.4,
              blurStyle: BlurStyle.inner,
            ),
          ],
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(100)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSessionSelectorButton(
                name: 'Recentes',
                selected: activity == ClubActivity.recentes,
                onPressed: () => setState(() {
                  activity = ClubActivity.recentes;
                }),
              ),
              _buildSessionSelectorButton(
                name: 'Leituras',
                selected: activity == ClubActivity.leituras,
                onPressed: () => setState(() {
                  activity = ClubActivity.leituras;
                }),
              ),
              _buildSessionSelectorButton(
                name: 'Encontros',
                selected: activity == ClubActivity.encontros,
                onPressed: () => setState(() {
                  activity = ClubActivity.encontros;
                }),
              ),
              addButton()
            ],
          ),
        ),
      ),
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 16),
      sliver: sessionSelector,
    );
  }

  Widget _buildSessionSelectorButton({
    required String name,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: selected ? colorScheme.primary : colorScheme.darkWhite,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: textTheme.labelMedium!.copyWith(
                color: selected ? colorScheme.white : colorScheme.primary
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionLoadingWidget() => SliverToBoxAdapter(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget _buildSessionErrorWidget() => SliverToBoxAdapter(
    child: Center(
      child: Text('Não foi possível acessar o clube'),
    ),
  );

  Widget _buildActivitiesInfiniteScroll<T>({
    required Paginator<T> paginator,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    final infiniteScroll = InfiniteGridWidget.sliver(
      paginator: paginator,
      controller: widget.scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
        childAspectRatio: 20/9,
      ),
      childrenDelegateProvider: (itens, totalItens) => (
        SliverChildBuilderDelegate(
          (context, index) => ActivityCard(
            activity: 'Nova meta de leitura',
            title: 'Alice no país das maravilhas',
            date: DateTime.now(),
          ),
          childCount: totalItens,
        )
      ),
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: infiniteScroll,
    );
  }

}