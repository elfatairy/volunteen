import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:volunteen/business_logic/handler/app_language/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/utility/cache_helper.dart';

class VolunteenAppLanguageListener extends StatelessWidget {
  final AppLanguageHandler appLanguageHandler;
  final Widget child;
  final BuildContext context;
  final AppRouter appRouter;

  VolunteenAppLanguageListener({
    super.key,
    required this.appRouter,
    required this.context,
    required this.appLanguageHandler,
    required this.child,
  }) {
    appLanguageHandler.stream.listen((state) {
      _newState(state);
    });
    _newState(appLanguageHandler.state);
  }

  _newState(AppLanguageState state) {
    context.setLocale(Locale(state.languageCode));
    CacheHelper.putString(key: 'languageCode', value: state.languageCode);
    appRouter.replaceAll([const MainRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
