import 'package:app/main.dart';

class ScreenPath {
  /// Auth path
  static const splash = '/';
  static const login = '/login';
  static const forgotPwd = '/forgotPwd';
  static const resetPwd = '/resetPwd';


  /// Main routes
  static const explore = '/explore';
  static const validation = '/validation';
  static const profile = '/profile';
  

  /// Sub -routes
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
