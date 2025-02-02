import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:volunteen/utility/cache_helper.dart';

part 'state.dart';

class AppLanguageHandler extends Cubit<AppLanguageState> {
  static String languageCode =
      CacheHelper.getString(key: 'languageCode') ?? 'ar';
  final BuildContext context;
  AppLanguageHandler({
    required this.context,
  }) : super(AppLanguageState(languageCode: languageCode));

  void changeLanguage(String languageCode) {
    emit(AppLanguageState(languageCode: languageCode));
  }

  @override
  void emit(AppLanguageState state) {
    if (state.languageCode != this.state.languageCode &&
        context.supportedLocales.contains(Locale(state.languageCode))) {
      super.emit(state);
    }
  }
}
