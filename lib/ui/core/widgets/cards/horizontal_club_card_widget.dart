import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalClubCardWidget extends StatelessWidget {

  final Club club;

  const HorizontalClubCardWidget({
    super.key,
    required this.club
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(36),
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(36),
    );

    final clubImage = CircleImageWidget.expanded(
      backgroundColor: colorScheme.white,
      borderColor: colorScheme.primary,
      borderWidth: 2,
      decorationImage: DecorationImage(
        image: NetworkImage(club.imageUrl!),
        fit: BoxFit.cover
      )
    );

    final clubInfo = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(club.name),
            Row(
              spacing: 8,
              children: [
                Icon(Icons.menu_book_rounded),
                Text('The Civil War Book Club'),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Icon(Icons.groups),
                Text('10'),
              ],
            ),
          ],
        ),
      )
    );

    return InkWell(
      onTap: () => context.push(Routes.clubProfile(clubId: club.id)),
      borderRadius: borderRadius,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            clubImage,
            clubInfo
          ],
        ),
      ),
    );
  }

}
