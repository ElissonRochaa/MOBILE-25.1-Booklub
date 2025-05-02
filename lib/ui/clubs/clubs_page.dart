import 'package:booklub/ui/clubs/view_models/clubs_view_model.dart';
import 'package:booklub/ui/clubs/widgets/club_vertical_card_widget.dart';
import 'package:booklub/ui/core/widgets/carousel/named_section_carousel_widget.dart';
import 'package:booklub/ui/core/widgets/grids/named_section_grid_widget.dart';
import 'package:booklub/ui/core/widgets/vertical_card_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key, required this.title});

  final String title;

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {

  @override
  Widget build(BuildContext context) {
    final cardHeight = _getCardHeight(context);
    final cardAspectRatio = _getCardAspectRatio();

    final cards = List.generate(10, (i) => VerticalCardWidget(
      imageProvider: NetworkImage('https://pt.quizur.com/_image?href=https://static.quizur.com/i/b/573e6c06640578.83502531573e6c06471173.49992186.png&w=1024&h=1024&f=webp'),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The Civil War',
            ),
          ],
        ),
      ),
    ));
    
    return MultiSliver(
      children: [
        Builder(builder: _buildMyClubsSection),
        SliverPadding(
            padding: const EdgeInsets.all(16),
        ),
        NamedSectionCarouselWidget.sliver(
          name: 'Recentes',
          height: cardHeight,
          aspectRatio: cardAspectRatio,
          showSeeMore: true,
          itemBuilder: (context, index) => cards[index],
          itemCount: cards.length,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
        ),
        NamedSectionGridWidget.sliver(
          name: 'Explorar',
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: cardHeight * cardAspectRatio,
            mainAxisExtent: cardHeight
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => cards[index],
            childCount: cards.length
          ),
        ),
      ],
    );
  }

  double _getCardHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.2;
  }

  double _getCardAspectRatio() => 3/4;

  Widget _buildMyClubsSection(BuildContext context) {
    final clubsViewModel = context.watch<ClubsViewModel>();
    final cardHeight = _getCardHeight(context);
    final cardAspectRatio = _getCardAspectRatio();

    final myClubs = clubsViewModel.myClubs;

    return NamedSectionCarouselWidget.sliver(
      name: 'Meus Clubes',
      height: cardHeight,
      aspectRatio: cardAspectRatio,
      showSeeMore: true,
      itemBuilder: (context, index) => AsyncBuilder(
        future: myClubs,
        onRetrieved: (data) => index < data.length
          ? ClubVerticalCardWidget(club: data[index])
          : const SizedBox.shrink(),
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onError: (_, _) => Placeholder(),
      ),
      itemCount: 11,
    );
  }

}