import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/book/individual_book_page.dart';
import 'package:booklub/ui/check-your-email-recover/check_your_email_recover_page.dart';
import 'package:booklub/ui/clubs/clubs_page.dart';
import 'package:booklub/ui/clubs/profile/club_profile_page.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/view_models/clubs_view_model.dart';
import 'package:booklub/ui/core/layouts/base_layout.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/ui/create_club/create_club_page.dart';
import 'package:booklub/ui/create_club/view_models/create_club_view_model.dart';
import 'package:booklub/ui/explore/explore_page.dart';
import 'package:booklub/ui/explore/layout/explore_layout.dart';
import 'package:booklub/ui/explore/widget/search_bar_widget.dart';
import 'package:booklub/ui/explore/view_model/explore_view_model.dart';
import 'package:booklub/ui/homepage/home_page.dart';
import 'package:booklub/ui/homepage/view_model/home_view_model.dart';
import 'package:booklub/ui/login/login_page.dart';
import 'package:booklub/ui/login/view_models/login_view_model.dart';
import 'package:booklub/ui/notifications/notifications_page.dart';
import 'package:booklub/ui/recover-password/recover_password_page.dart';
import 'package:booklub/ui/recover-password/view_models/recover_password_view_model.dart';
import 'package:booklub/ui/register/register_page.dart';
import 'package:booklub/ui/register/view_models/register_view_model.dart';
import 'package:booklub/ui/user/edit/edit_profile_page.dart';
import 'package:booklub/ui/user/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract final class RoutingConfig {
  static GoRouter createRouter(AuthViewModel authViewModel) => GoRouter(
    initialLocation: Routes.home,
    refreshListenable: authViewModel,
    redirect: (context, state) async {
      final isLoggedIn = await authViewModel.validateToken();
      final isGoingToAuthPage =
          (state.uri.path == Routes.register ||
              state.uri.path == Routes.login ||
              state.uri.path == Routes.recoverPassword ||
              state.uri.path == Routes.checkYourEmailRecover);

      if (!isLoggedIn && !isGoingToAuthPage) return Routes.login;
      if (isLoggedIn && isGoingToAuthPage) return Routes.home;

      return null;
    },
    routes: [
      GoRoute(
        name: 'Home',
        path: Routes.home,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) => HomeViewModel(
                    clubRepository: context.read(),
                    authRepository: context.read(),
                  ),
              child: BaseLayout(child: const HomePage()),
            ),
      ),
      GoRoute(
        name: 'Clubs',
        path: Routes.clubs,
        builder:
          (context, state) => ChangeNotifierProvider(
            create: (context) => ClubsViewModel(
              clubRepository: context.read(),
              authViewModel: context.read(),
            ),
            child: ScrollBaseLayout(sliver: ClubsPage(title: 'Clubes')),
          ),
      ),
      GoRoute(
        name: 'Club Profile',
        path: Routes.clubProfile(),
        builder: (context, state) {
          final clubId = state.pathParameters['id'];
          return ChangeNotifierProvider(
            create: (context) => ClubProfileViewModel(
              clubRepository: context.read(),
              readingGoalsRepository: context.read(),
              meetingsRepository: context.read(),
              activityRepository: context.read(),
              authViewModel: context.read(),
              clubId: clubId!,
            ),
            child: ScrollBaseLayout(sliver: ClubProfilePage()),
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
        name: 'Notifications',
        path: Routes.notifications,
        builder:
            (context, state) =>
                const ScrollBaseLayout(sliver: NotificationsPage()),
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
        name: 'Create Club',
        path: Routes.createClub,
        builder: (context, state) => ScrollBaseLayout(
          label: 'Criar Clube',
          bottomBarVisible: false,
          sliver: ChangeNotifierProvider(
            create: (_) => CreateClubViewModel(
              authRepository: context.read(),
              clubRepository: context.read(),
              ioRepository: context.read()
            ),
            child: CreateClubPage(),
          ),
        ),
      ),
      GoRoute(
        name: 'Login',
        path: Routes.login,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (context) => LoginViewModel(
                    authRepository: context.read(),
                    inputValidators: context.read(),
                  ),
              child: ScrollBaseLayout(
                appBarVisible: false,
                bottomBarVisible: false,
                sliver: LoginPage(),
              ),
            ),
      ),
      GoRoute(
        name: 'Recover password',
        path: Routes.recoverPassword,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (context) => RecoverPasswordViewModel(
                    authRepository: context.read(),
                    inputValidators: context.read(),
                  ),
              child: ScrollBaseLayout(
                appBarVisible: false,
                bottomBarVisible: false,
                sliver: RecoverPasswordPage(),
              ),
            ),
      ),
      GoRoute(
        name: 'Check your e-mail for recovery password link',
        path: Routes.checkYourEmailRecover,
        builder:
            (context, state) => ScrollBaseLayout(
              appBarVisible: false,
              bottomBarVisible: false,
              sliver: CheckYourEmailRecoverPage(),
            ),
      ),
      GoRoute(
        name: 'Register',
        path: Routes.register,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (context) => RegisterViewModel(
                    authRepository: context.read(),
                    inputValidators: context.read(),
                    ioRepository: context.read(),
                  ),
              child: ScrollBaseLayout(
                appBarVisible: false,
                bottomBarVisible: false,
                sliver: RegisterPage(),
              ),
            ),
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
        builder:
            (context, state) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create:
                      (_) => ExploreViewModel(
                        userRepository: context.read(),
                        bookApiRepository: context.read(),
                        clubRepository: context.read()
                      ),
                ),
                ChangeNotifierProvider(create: (_) => SearchQueryNotifier()),
              ],
              child: ExploreLayout(sliver: ExplorePage()),
            ),
      ),
    ],
  );
}
