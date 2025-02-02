import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/app_language/handler.dart';
import 'package:volunteen/presentation/themes/colors.dart';

class VolunteenChangeLanguage extends StatelessWidget {
  const VolunteenChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const VolunteenChangeLanguageAlertDialog(),
      ),
      child: VolunteenCountryFlag(
        languageCode: context.locale.languageCode.toUpperCase(),
      ),
    );
  }
}

class VolunteenChangeLanguageAlertDialog extends StatelessWidget {
  const VolunteenChangeLanguageAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLanguageHandler appLanguageHandler = context.read();
    return AlertDialog(
      backgroundColor: VolunteenColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => appLanguageHandler.changeLanguage('ar'),
            child: const VolunteenCountryFlag(languageCode: 'ar'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => appLanguageHandler.changeLanguage('en'),
            child: const VolunteenCountryFlag(languageCode: 'en'),
          ),
        ],
      ),
    );
  }
}

class VolunteenCountryFlag extends StatelessWidget {
  final String languageCode;
  const VolunteenCountryFlag({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromLanguageCode(
      languageCode,
      height: 38,
      width: 52,
      shape: const RoundedRectangle(10),
    );
  }
}
