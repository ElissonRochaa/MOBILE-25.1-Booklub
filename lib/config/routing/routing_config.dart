import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/clubs/clubs_page.dart';
import 'package:booklub/ui/clubs/profile/club_profile_page.dart';
import 'package:booklub/ui/core/layouts/base_layout.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../ui/login/login_page.dart';
import '../../ui/register/register_page.dart';
import 'package:booklub/ui/book/individual_book_page.dart';


abstract final class RoutingConfig {

  static GoRouter get router => GoRouter(
    //MUDAR LINHA ABAIXO ANTES DE COMITTAR
    // initialLocation: Routes.clubs,
    initialLocation: Routes.individualBook(bookId: 'mock-book'),
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
        ),
        GoRoute(
            name: 'Login',
            path: Routes.login,
            builder: (context, state) => LoginPage(),
        ),
        GoRoute(
            name: 'Register',
            path: Routes.register,
            builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          name: 'Individual Book',
          path: Routes.individualBook(),
          builder: (context, state) {
            final bookId = state.pathParameters['id'];
            return IndividualBookPage(bookId: bookId!);
          },
        ),
      ]
  );

}