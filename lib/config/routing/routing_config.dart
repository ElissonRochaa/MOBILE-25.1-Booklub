import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/clubs/clubs_page.dart';
import 'package:booklub/ui/clubs/profile/club_profile_page.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:booklub/ui/explore/explore_page.dart';
import 'package:booklub/ui/explore/layout/explore_layout.dart';
import 'package:go_router/go_router.dart';
import '../../ui/login/login_page.dart';
import '../../ui/register/register_page.dart';
import 'package:booklub/ui/book/individual_book_page.dart';
import 'package:booklub/ui/user/profile_page.dart';
import 'package:booklub/ui/user/edit/edit_profile_page.dart';

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
              sliver: ClubProfilePage(
                clubId: clubId!,
              )
            );
          },
        ),
        GoRoute(
          name: 'User Profile',
          path: Routes.userProfile(),
          builder: (context, state) {
            final userIdFromRoute = state.pathParameters['id'];
            final currentUserId = 'abc123';
            final isMyOwnProfile = (userIdFromRoute == currentUserId);

          return ScrollBaseLayout(
            sliver: ProfilePage(
              userId: userIdFromRoute!,
              isMyOwnUserProfile: isMyOwnProfile,
            ),
          );
        },
      ),

      GoRoute(
        name: 'Edit Profile',
        path: Routes.edit(),
        builder:
            (context, state) => ScrollBaseLayout(
              sliver: EditProfilePage(),
              bottomBarVisible: false,
            ),
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
      GoRoute(
          name: 'Explore',
          path: Routes.explore,
          builder: (context, state) => ExploreLayout(
            sliver: ExplorePage()
          ),
        ),
    ],
  );
}

