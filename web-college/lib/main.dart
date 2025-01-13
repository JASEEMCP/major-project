import 'package:flutter/material.dart';
import 'package:app/domain/app_logic.dart';
import 'package:app/presentation/root_app.dart';
import 'package:app/resource/db/pref_info.dart';
import 'package:app/resource/injectable.dart';
import 'package:app/router/router.dart';
import 'package:app/styles/styles.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  //Configuring injection
  await configureInjection();

  runApp(const RootApp());

  // Starting bootstrap
  await appLogic.bootstrap();
}


AppStyle get $style => RootApp.style;
final appRouter = AppRouter.router;
PrefInfo get pref => getIt<PrefInfo>();
AppLogic get appLogic => getIt<AppLogic>();