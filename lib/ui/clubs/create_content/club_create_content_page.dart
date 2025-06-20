import 'package:flutter/material.dart';

class ClubCreateContentPage extends StatelessWidget {

  final String clubId;

  const ClubCreateContentPage({
    super.key,
    required this.clubId
  });

  @override
  Widget build(BuildContext context) {
    final tiles = [
      ListTile(
        title: Text('Criar meta de leitura'),

      ),
      ListTile(
        title: Text('Criar meta de leitura'),
      ),
    ];

    return SliverToBoxAdapter(
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: tiles
        ).toList(),
      ),
    );
  }

}
