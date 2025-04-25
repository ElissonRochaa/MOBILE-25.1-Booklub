import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/core/layouts/base_layout.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:booklub/ui/groups/groups_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class RoutingConfig {

  static GoRouter get router => GoRouter(
    initialLocation: Routes.groups,
      routes: [
        GoRoute(
          name: 'Groups',
          path: Routes.groups,
          builder: (context, state) => ScrollBaseLayout(
              sliver: GroupsPage(title: 'Groups')
          ),
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