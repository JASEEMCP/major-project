import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:app/styles/theme.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.initial());

  ThemeType theme = ThemeType.light;
  AppTheme appTheme = AppTheme.fromType(ThemeType.light);
  changeTheme() {
    if (theme == ThemeType.light) {
      theme = ThemeType.dark;
      appTheme = AppTheme.fromType(theme);
      emit(ThemeState.theme(theme));
    } else {
      theme = ThemeType.light;
      appTheme = AppTheme.fromType(theme);

      emit(ThemeState.theme(theme));
    }
  }
}
