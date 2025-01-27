

import 'package:app/presentation/auth/forgot_pwd/forgot_pwd_view.dart';
import 'package:app/presentation/auth/forgot_pwd/reset_pwd_view.dart';
import 'package:app/presentation/auth/login_screen.dart';
import 'package:app/presentation/main_screen/auth_main.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/router/transitions.dart';

class AuthShell {
  static final _authNavigatorKey = GlobalKey<NavigatorState>();
  List<RouteBase> authList = [
    ///Auth Navigation shell
    ShellRoute(
      navigatorKey: _authNavigatorKey,
      builder: (context, state, child) {
        return AuthMainScreen(
          key: state.pageKey,
          child: child,
        );
      },
      routes: [
        // Login Screen
        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.login,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: ScreenLogin(),
            );
          },
          
        ),
          // Forgot Password Screen
        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.forgotPwd,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: ForgotPwdView(),
            );
          },
        ),
        // Reset PWd
        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.resetPwd,
          pageBuilder: (context, state) {
            return const CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: ResetPwdView(),
            );
          },
        ),
        
      ],
    ),
  ];
 
}
