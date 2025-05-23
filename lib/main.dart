import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:booklub/config/routing/routing_config.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:provider/provider.dart';
import 'config/theme/theme_config.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthRepository>(
        create: (context) => AuthRepository(),
      ),
      ChangeNotifierProvider<AuthViewModel>(
        create: (context) => AuthViewModel(
          authRepository: context.read(),
        )
      ),
      Provider<InputValidators>(
        create: (context) => InputValidators(),
      ),
      ChangeNotifierProvider<ThemeContext>.value(
        value: ThemeConfig.themeContext
      ),
      Provider<GoRouter>(
        create: (context) => RoutingConfig.createRouter(context.read()),
      ),
      Provider<ClubRepository>(
        create: (context) => ClubRepository(),
      ),
      Provider<IORepository>(create: (context) => IORepository()),
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


