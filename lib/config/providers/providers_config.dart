import 'package:booklub/config/env/env_config.dart';
import 'package:booklub/config/routing/routing_config.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:booklub/infra/reading_goals/reading_goals_repository.dart';
import 'package:booklub/infra/user/user_repository.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:go_router/go_router.dart' hide RoutingConfig;
import 'package:provider/provider.dart';

abstract final class ProvidersConfig {

  static final env = EnvConfig.env;

  static final providers = [
    Provider<AuthRepository>(
        create: (context) => AuthRepository(apiUrl: env.apiUrl)
    ),
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(authRepository: context.read()),
    ),
    Provider<InputValidators>(create: (context) => InputValidators()),
    ChangeNotifierProvider<ThemeContext>.value(
      value: ThemeConfig.themeContext,
    ),
    Provider<GoRouter>(
      create: (context) => RoutingConfig.createRouter(context.read()),
    ),
    Provider<ClubRepository>(create: (context) => ClubRepository(
        apiUrl: env.apiUrl,
        authRepository: context.read()
    )),
    Provider<UserRepository>(create: (context) => UserRepository(
        apiUrl: env.apiUrl,
        authRepository: context.read()
    )),
    Provider<IORepository>(create: (context) => IORepository()),
    Provider<ReadingGoalsRepository>(create: (context) => ReadingGoalsRepository(
      authRepository: context.read(),
      apiUrl: env.apiUrl,
    )),
  ];



}