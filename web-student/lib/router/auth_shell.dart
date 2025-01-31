import 'package:app/presentation/auth/forgot_pwd/forgot_pwd_view.dart';
import 'package:app/presentation/auth/forgot_pwd/reset_pwd_view.dart';
import 'package:app/presentation/auth/login_screen.dart';
import 'package:app/presentation/auth/sign_up/create_sign_up.dart';
import 'package:app/presentation/auth/sign_up/profile_submission.dart';
import 'package:app/presentation/auth/sign_up/sign_up_screen.dart';
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

        // Signup
        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.signup,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: SignUpScreen(),
            );
          },
        ),

        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.signupPwd,
          pageBuilder: (context, state) {
            return const CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: CreateSignUp(),
            );
          },
        ),
        // Reset PWd
        GoRoute(
          parentNavigatorKey: _authNavigatorKey,
          path: ScreenPath.signupProfile,
          pageBuilder: (context, state) {
            return const CustomTransitionPage(
              transitionsBuilder: useNavChangeTransition,
              child: ProfileSubmission(),
            );
          },
        ),
      ],
    ),
  ];
}
