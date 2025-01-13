import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:injectable/injectable.dart';
import 'package:app/resource/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureInjection() async {
  init(getIt, environment: Environment.dev);
}
