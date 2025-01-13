import 'package:envied/envied.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/infrastructure/env/env_keys.dart';


part 'dev_env.g.dart';

@Envied(name: 'Env', path: '.env.dev')
final class DevelopmentEnv implements Env, EnvKeys {
  

  @override
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  final String apiBaseUrl = _Env.apiBaseUrl;

  
}
