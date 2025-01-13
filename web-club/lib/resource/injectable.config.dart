// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../application/auth/token_cubit/token_cubit.dart' as _i98;
import '../application/common/theme_cubit/theme_cubit.dart' as _i509;
import '../domain/app_logic.dart' as _i659;
import 'api/dio_client.dart' as _i891;
import 'db/pref_info.dart' as _i29;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i98.TokenCubit>(() => _i98.TokenCubit());
  gh.lazySingleton<_i509.ThemeCubit>(() => _i509.ThemeCubit());
  gh.lazySingleton<_i659.AppLogic>(() => _i659.AppLogic());
  gh.lazySingleton<_i29.PrefInfo>(() => _i29.PrefInfo());
  gh.lazySingleton<_i891.DioClient>(
      () => _i891.DioClient(gh<_i98.TokenCubit>()));
  return getIt;
}
