import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/help_request_info_row.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

class HelpRequestDetailsColumn extends StatelessWidget {
  final HelpRequest helpRequest;
  const HelpRequestDetailsColumn({
    super.key,
    required this.helpRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            helpRequest.description,
            style: const TextStyle(
              fontSize: 16.0,
              color: VolunteenColors.darkBlue,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 16.0),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_service_type.tr(),
          value: StringUtility.getHelpCategoryName(
            helpRequest.category,
            context,
          ),
        ),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_location.tr(),
          value: helpRequest.locationInDetails,
        ),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_day.tr(),
          value: helpRequest.day,
        ),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_hour.tr(),
          value: helpRequest.hour,
        ),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_phone_number.tr(),
          value: helpRequest.phoneNumber,
        ),
        HelpRequestInfoRow(
          label: LocaleKeys.service_detailed_whatsapp_number.tr(),
          value: helpRequest.whatsAppNumber,
        ),
      ],
    );
  }
}
