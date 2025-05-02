import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/clubs/clubs_page.dart';
import 'package:booklub/ui/clubs/profile/club_profile_page.dart';
import 'package:booklub/ui/core/layouts/base_layout.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class RoutingConfig {

  static GoRouter get router => GoRouter(
    initialLocation: Routes.clubs,
      routes: [
        GoRoute(
          name: 'Clubs',
          path: Routes.clubs,
          builder: (context, state) => ScrollBaseLayout(
            sliver: ClubsPage(title: 'Clubes')
          ),
        ),
        GoRoute(
            name: 'Club Profile',
            path: Routes.clubProfile(),
            builder: (context, state) {
              final clubId = state.pathParameters['id'];
              return ScrollBaseLayout(
                sliver: ClubProfilePage(clubId: clubId!)
              );
            },
        ),
        ShellRoute(
          builder: (context, state, child) => BaseLayout(child: child),
          routes: [
            GoRoute(
              name: 'Profile',
              path: Routes.profile,
              builder: (context, state) => const Placeholder(),
            ),
          ]
        )
      ]
  );

}