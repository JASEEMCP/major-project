

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/application/common/theme_cubit/theme_cubit.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/resource/register_cubit.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:app/router/router.dart';
import 'package:app/styles/styles.dart';
import 'package:app/styles/theme.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        ...RegisterCubits().register(),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
           _style = AppStyle(screenSize: context.mq);
          return MaterialApp.router(
            title: 'Name',
            debugShowCheckedModeBanner: Env.kDebugMode,
            theme: AppTheme.fromType(ThemeType.light).themeData,
            routerConfig: AppRouter.router,
            
          );
        },
      ),
    );
  }
}
