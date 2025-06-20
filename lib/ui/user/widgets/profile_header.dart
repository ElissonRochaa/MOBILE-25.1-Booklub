import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends StatelessWidget {
  /// The [ProfileHeader] widget is a custom header for a user profile page.
  /// It displays the user's name, username, and a button to edit or follow the user.
  final String name;
  final String username;
  final String avatarUrl;
  final int quantidadeFriends;
  final bool isMyOwnUserProfile;
  final String userId;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.quantidadeFriends,
    required this.isMyOwnUserProfile,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final profilePic = DecorationImage(
      image: NetworkImage(avatarUrl)
    );

    print(avatarUrl);

    return Column(
      children: [
        Text(
          "Perfil",
          style: textTheme.titleLarge!.copyWith(
            color: colorScheme.primary,
            fontFamily: "Navicula",
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        CircleImageWidget(
          radius: 160,
          borderWidth: 2,
          decorationImage: profilePic,
          backgroundColor: colorScheme.primary,
          borderColor: colorScheme.primary,
        ),
        Text(
          name,
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.onSurface,
            fontFamily: "Navicula",
            height: 1.5,
          ),
        ),
        Text(
          "@$username",
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.primary,
            fontFamily: "Navicula",
            height: 0.5,
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainer,
                minimumSize: Size(80, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    quantidadeFriends.toString(),
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'bookfriends',
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isMyOwnUserProfile) {
                  context.push(Routes.edit(userId: userId));
                } else {
                  // lógica para seguir outro usuário [seguir]
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(140, 59),
                backgroundColor:
                    isMyOwnUserProfile
                        ? colorScheme.primary
                        : Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isMyOwnUserProfile ? "Editar" : "Seguir",
                style: textTheme.headlineSmall!.copyWith(
                  color: colorScheme.onPrimary,
                  fontFamily: "Navicula",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
