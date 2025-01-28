import 'package:app/main.dart';

class ScreenPath {
  /// Auth path
  static const splash = '/';
  static const login = '/login';
  static const resetPwd = '/reset-pwd';
  static const forgotPwd = '/forgot-pwd';
  static const signup = '/signup';
  static const signupPwd = '/signup-pwd';
  static const signupProfile = '/signup-profile';

  /// Main Routes
  static const staff = '/staff';
  static const department = '/department';
  static const profile = '/profile';
  static const explore = '/explore';

  /// Sub-Routes

  static detail(String id) => _appendIdIntoCurrentPath('/detail/$id');

  ///Appending path
  static _appendIdIntoCurrentPath(String path) {
    final newPathUri = Uri.parse(path);
    final currentPathUri = appRouter.routeInformationProvider.value.uri;
    Map<String, dynamic> parm = Map.of(currentPathUri.queryParameters);
    parm.addAll(newPathUri.queryParameters);
    Uri? loc = Uri(
        path: '${currentPathUri.path}/${newPathUri.path}'.replaceAll('//', '/'),
        queryParameters: parm);
    final newPath = path.replaceAll('/', '');
    return loc.toString().replaceAll('$newPath/$newPath', newPath);
  }
}
