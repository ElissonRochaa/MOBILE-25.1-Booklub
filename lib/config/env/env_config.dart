import 'package:booklub/config/env/env.dart';

abstract final class EnvConfig {

  static const env = Env(
    apiUrl: String.fromEnvironment("API_URL", defaultValue: '')
  );

  static void checkEnvVars() {
    final missingEnvVars = [];

    if (env.apiUrl.isEmpty) {
      missingEnvVars.add('API_URL');
    }

    if (missingEnvVars.isNotEmpty) {
      throw Exception(
        'Missing environment variables: ${missingEnvVars.join(', ')}\n'
        'Please, set the environment variables in the .env file and ensure '
        'the argument --dart-define-from-file was passed to the Dart executable'
      );
    }
  }

}