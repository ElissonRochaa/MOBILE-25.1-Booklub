import 'package:booklub/config/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClubCreateContentPage extends StatelessWidget {

  final String clubId;

  const ClubCreateContentPage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    final tiles = [
      ListTile(
        title: Text('Criar meta de leitura'),
        onTap: (){
          context.push(Routes.createReadingGoal(clubId: clubId));
        }
      ),
      ListTile(
        title: Text('Criar encontro'),
        onTap: (){
          context.push(Routes.createMeeting(clubId: clubId));
        }
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
