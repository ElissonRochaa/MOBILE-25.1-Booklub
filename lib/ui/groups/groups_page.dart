import 'package:booklub/ui/core/widgets/named_section_widget.dart';
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

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: NamedSectionWidget(
              name: 'Meus Clubes',
              showSeeMore: true,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => cards[index],
              childCount: cards.length,
            ),
          ),
        ],
      )
    );
  }

}