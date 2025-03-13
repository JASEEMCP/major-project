import 'package:app/application/auth/token_cubit/token_cubit.dart';
import 'package:app/firebase_options.dart';
import 'package:app/resource/api/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/app_logic.dart';
import 'package:app/presentation/root_app.dart';
import 'package:app/resource/db/pref_info.dart';
import 'package:app/resource/injectable.dart';
import 'package:app/router/router.dart';
import 'package:app/styles/styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Configuring injection
  await configureInjection();
try{
   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  print("FCM Token: $token");
}
catch(e){
  print("Firebase Error: $e");
}
  runApp(const RootApp());

  // Starting bootstrap
  await appLogic.bootstrap();
}

AppStyle get $style => RootApp.style;
final appRouter = AppRouter.router;
PrefInfo get pref => getIt<PrefInfo>();
AppLogic get appLogic => getIt<AppLogic>();
TokenCubit get tokenCubit => getIt<TokenCubit>();
DioClient get dioClient => getIt<DioClient>();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  print("Background message received: ${message.notification?.title}");
}