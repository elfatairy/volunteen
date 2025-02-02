import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/listener/language.dart';
import 'package:volunteen/business_logic/listener/session_listener.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/presentation/themes/app_themes.dart';

class VolunteenApp extends StatelessWidget {
  const VolunteenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(sessionHandler: context.read());
    return VolunteenSessionAppStateListener(
      router: appRouter,
      handler: context.read(),
      child: VolunteenAppLanguageListener(
        appRouter: appRouter,
        appLanguageHandler: context.read(),
        context: context,
        child: AdaptiveTheme(
          light: AppThemes.appThemeData[AppTheme.lightTheme]!,
          dark: AppThemes.appThemeData[AppTheme.lightTheme]!,
          initial: AdaptiveThemeMode.light,
          builder: (light, dark) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Volunteen',
              theme: light,
              darkTheme: dark,
              routerConfig: appRouter.config(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            );
          },
        ),
      ),
    );
  }
}
