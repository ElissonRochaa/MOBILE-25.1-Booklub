import 'package:booklub/ui/core/widgets/carousel/named_section_carousel.dart';
import 'package:booklub/ui/core/widgets/vertical_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key, required this.title});

  final String title;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardHeight = MediaQuery.of(context).size.height * 0.2;
    final cardAspectRatio = 3/4;

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
        NamedSectionCarousel.sliver(
          name: 'Meus Clubes',
          height: cardHeight,
          aspectRatio: cardAspectRatio,
          showSeeMore: true,
          itemBuilder: (context, index) => cards[index],
          itemCount: cards.length,
        ),
        SliverPadding(
            padding: const EdgeInsets.all(16),
        ),
        NamedSectionCarousel.sliver(
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
        NamedSectionCarousel.sliver(
          name: 'Não sei',
          height: cardHeight,
          aspectRatio: cardAspectRatio,
          showSeeMore: true,
          itemBuilder: (context, index) => cards[index],
          itemCount: cards.length,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
        ),
        NamedSectionCarousel.sliver(
          name: 'Não sei 2',
          height: cardHeight,
          aspectRatio: cardAspectRatio,
          showSeeMore: true,
          itemBuilder: (context, index) => cards[index],
          itemCount: cards.length,
        ),
      ],
    );
  }

}