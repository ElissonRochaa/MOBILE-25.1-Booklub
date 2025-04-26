import 'package:booklub/ui/core/widgets/carousel/named_section_carousel.dart';
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
    final cards = List.generate(10, (i) => Card(
      child: Text('Card $i'),
    ));

    return MultiSliver(
      children: [
        NamedSectionCarousel.sliver(
          name: 'Meus Clubes',
          height: 200,
          showSeeMore: true,
          itemBuilder: (context, index) => cards[index],
          itemCount: cards.length,
        ),
      ],
    );
  }

}