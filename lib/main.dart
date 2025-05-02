import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:booklub/config/routing/routing_config.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:provider/provider.dart';
import 'config/theme/theme_config.dart';
import 'ui/clubs/view_models/clubs_view_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeContext>.value(
          value: ThemeConfig.themeContext
      ),
      Provider<GoRouter>.value(
        value: RoutingConfig.router,
      ),
      Provider<ClubRepository>(
        create: (context) => ClubRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => ClubsViewModel(
          clubRepository: context.read(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeContext = context.watch<ThemeContext>();
    final router = context.read<GoRouter>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Booklub',
      theme: themeContext.activeTheme.themeData,
      routerConfig: router,
    );
  }
}


