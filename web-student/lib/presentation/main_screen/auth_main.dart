import 'package:app/presentation/home/screen/event_detail_screen.dart';
import 'package:app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AuthMainScreen extends StatefulWidget {
  const AuthMainScreen({super.key, required this.child});
  final Widget child;

  @override
  State<AuthMainScreen> createState() => _AuthMainScreenState();
}

class _AuthMainScreenState extends State<AuthMainScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permissions
    NotificationSettings settings = await messaging.requestPermission();
    print("User granted permission: ${settings.authorizationStatus}");

    // Get and print the FCM token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground notification received: ${message.notification?.title}");

      // Show a local notification
      _showLocalNotification(
        message.notification?.title ?? "No Title",
        message.notification?.body ?? "No Body",
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);
      AppRouter.rootkey.currentState?.push(MaterialPageRoute(builder: (ctx)=>EventDetailScreen(id: message.data['event_id'])));
    });
  }

  void _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
