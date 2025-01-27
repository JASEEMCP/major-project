import 'package:app/main.dart';
import 'package:app/presentation/explore/add_department_view.dart';
import 'package:app/presentation/explore/add_staff_view.dart';
import 'package:app/presentation/explore/screen/college_detail.dart';
import 'package:app/presentation/profile/profile_view.dart';
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
                child: CollegeDetailView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
          ),
          GoRoute(
            path: ScreenPath.staff,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const CustomTransitionPage(
                child: AddStaffView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
          ),

          GoRoute(
            path: ScreenPath.department,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const CustomTransitionPage(
                child: AddDepartmentView(),
                transitionsBuilder: useNavChangeTransition,
              );
            },
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
  final a = appLogic;
  if (state.uri.path == ScreenPath.splash && !a.isBootStrapComplete) {
    return ScreenPath.splash;
  }
  if (!a.isBootStrapComplete) {
    _initialDeepLink ??= state.uri.toString();
    return ScreenPath.splash;
  }

  return null;
}
