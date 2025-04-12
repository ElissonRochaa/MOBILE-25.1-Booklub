import 'package:booklub/config/routing/routes.dart';
import 'package:go_router/go_router.dart';

import '../../ui/home/home_page.dart';

abstract final class RoutingConfig {

  static GoRouter get router => GoRouter(
    initialLocation: Routes.home,
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const MyHomePage(title: 'Home'),
        ),
      ]
  );

}