import 'package:app/presentation/home/home_view.dart';
import 'package:app/presentation/home/my_event_view.dart';
import 'package:app/presentation/home/profile_view.dart';
import 'package:app/presentation/home/screen/event_detail_screen.dart';
import 'package:app/presentation/home/screen/my_event_detail.dart';
import 'package:app/router/auth_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/presentation/main_screen/main_screen.dart';
import 'package:app/router/router_path.dart';
import 'package:app/router/transitions.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: ScreenPath.splash,
    redirect: _handleRedirect,
    redirectLimit: 10,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// Splash Screen
      GoRoute(
        path: ScreenPath.splash,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: Container(),
            transitionsBuilder: useNavChangeTransition,
          );
        },
      ),

      ...AuthShell().authList,

      ///Navigation shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScreenMain(
            key: state.pageKey,
            child: child,
          );
        },
        routes: [
          /// Home
          GoRoute(
            path: ScreenPath.explore,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const CustomTransitionPage(
                child: HomeView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
            routes: [
              GoRoute(
                path: 'detail/:id',
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return  CustomTransitionPage(
                    child: EventDetailScreen(id: state.pathParameters['id'].toString()),
                    transitionsBuilder: useNavChangeTransition,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: ScreenPath.history,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const CustomTransitionPage(
                child: MyEventView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
            routes: [
              GoRoute(
                path: 'detail/:id',
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return  CustomTransitionPage(
                    child: MyEventDetailScreen(id: state.pathParameters['id'].toString()),
                    transitionsBuilder: useNavChangeTransition,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: ScreenPath.profile,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const CustomTransitionPage(
                child: ProfileView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
          ),

          /// Profile
        ],
      ),
    ],
  );
}

String? _initialDeepLink;
String? get initialDeepLink => _initialDeepLink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  return null;
}
