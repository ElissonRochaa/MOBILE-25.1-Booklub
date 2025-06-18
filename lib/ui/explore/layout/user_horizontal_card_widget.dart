import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:booklub/ui/core/widgets/vertical_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserHorizontalCardWidget extends StatelessWidget {
  final User user;

  const UserHorizontalCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final userProfileImage =
        user.imageUrl == null
            ? "https://i.imgur.com/Dtuoq5K.jpeg"
            : user.imageUrl!;

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(36),
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(36),
    );

    final clubImage = CircleImageWidget.expanded(
      backgroundColor: colorScheme.onPrimary,
      borderColor: colorScheme.primary,
      borderWidth: 2,
      decorationImage: DecorationImage(
        image: NetworkImage(userProfileImage),
        fit: BoxFit.cover,
      ),
    );

    final clubInfo = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.fullName),
            Row(spacing: 8, children: [Icon(Icons.groups), Text('10')]),
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () => (),
      borderRadius: borderRadius,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [clubImage, clubInfo],
        ),
      ),
    );
  }
}
