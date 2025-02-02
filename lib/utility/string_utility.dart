import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

class StringUtility {
  static String getHelpCategoryName(
    final HelpCategory helpCategory,
    final BuildContext context,
  ) {
    switch (helpCategory) {
      case HelpCategory.childCare:
        return LocaleKeys.help_requests_child_care.tr();
      case HelpCategory.delivery:
        return LocaleKeys.help_requests_delivery_services.tr();
      case HelpCategory.elderlyHelp:
        return LocaleKeys.help_requests_elderly_care.tr();
      case HelpCategory.petCare:
        return LocaleKeys.help_requests_pet_care.tr();
      case HelpCategory.other:
        return LocaleKeys.help_requests_other_category.tr();
    }
  }

  static String getHelpingHandCategoryName(
    final HelpingHandCategory helpCategory,
    final BuildContext context,
  ) {
    switch (helpCategory) {
      case HelpingHandCategory.mentalHealth:
        return LocaleKeys.helping_hands_mental_health.tr();
      case HelpingHandCategory.family:
        return LocaleKeys.helping_hands_family.tr();
      case HelpingHandCategory.health:
        return LocaleKeys.helping_hands_medical.tr();
      case HelpingHandCategory.education:
        return LocaleKeys.helping_hands_education.tr();
    }
  }

  static String getHelpCategoryImagePath(final HelpCategory helpCategory) {
    const String imagesPath = "assets/images/main_screen/help_requests";
    switch (helpCategory) {
      case HelpCategory.childCare:
        return '$imagesPath/child_care.png';
      case HelpCategory.delivery:
        return '$imagesPath/assistance.png';
      case HelpCategory.elderlyHelp:
        return '$imagesPath/elderly_care.png';
      case HelpCategory.petCare:
        return '$imagesPath/pets_care.png';
      case HelpCategory.other:
        return '$imagesPath/other.png';
    }
  }
}
