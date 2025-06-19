import 'package:booklub/config/env/env_config.dart';
import 'package:booklub/config/providers/providers_config.dart';
import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/ui/core/splash_animations/splash_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:provider/provider.dart';

void main() {
  EnvConfig.checkEnvVars();

  runApp(
    MultiProvider(
      providers: ProvidersConfig.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeContext = context.watch<ThemeContext>();
    final router = context.read<GoRouter>();

    return SplashWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Booklub',
        theme: themeContext.activeTheme.themeData,
        routerConfig: router,
      ),
    );
  }
}
