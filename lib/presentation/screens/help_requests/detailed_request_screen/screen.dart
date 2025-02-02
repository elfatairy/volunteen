// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/help_request_detailed/handler.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/data/models/user.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/help_request_detailed_column.dart';
import 'package:volunteen/presentation/widgets/help_request_info_row.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class HelpRequestDetailScreen extends StatelessWidget {
  final HelpRequest helpRequest;
  VolunteenUser helpingUser = VolunteenUser.emptyUser;

  HelpRequestDetailScreen({
    Key? key,
    required this.helpRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(
          helpRequest.title,
        ),
      ),
      body: BlocProvider(
        create: (context) => HelpRequestDetailedHandler(
          helpRequestRepository: context.read(),
          userRepository: context.read(),
        ),
        child:
            BlocBuilder<HelpRequestDetailedHandler, HelpRequestDetailedState>(
          builder: (context, state) {
            final HelpRequestDetailedHandler helpRequestDetailedHandler =
                context.read();
            if (helpRequest.helpingUserId != null && helpingUser.id.isEmpty) {
              helpRequestDetailedHandler
                  .getVolunteenUser(helpRequest.helpingUserId!);
              helpingUser = helpRequestDetailedHandler.volunteenUser;
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelpRequestDetailsColumn(
                    helpRequest: helpRequest,
                  ),
                  if (helpRequest.helpingUserId != null)
                    HelpRequestInfoRow(
                      label: LocaleKeys.service_detailed_volunteering_user.tr(),
                      value: helpingUser.name,
                    ),
                  Center(
                    child: VolunteenFilledElevatedButton(
                      text:
                          LocaleKeys.service_detailed_delete_this_request.tr(),
                      onPressed: () {
                        context.router.maybePop();
                        helpRequestDetailedHandler
                            .deleteHelpRequest(helpRequest.id);
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
