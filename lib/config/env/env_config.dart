import 'package:booklub/config/env/env.dart';

abstract final class EnvConfig {

  static const env = Env(
    apiUrl: String.fromEnvironment("API_URL")
  );

}