import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/help_request_load/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/help_request_card.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class HelpRequestsScreen extends StatelessWidget {
  const HelpRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              LocaleKeys.my_services_screen_services_list_title.tr(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return HelpRequestsDialog(
                        alertDialogContext: alertDialogContext);
                  },
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) {
          final handler = HelpRequestLoadHandler(
            helpRequestRepository: context.read(),
          );
          final sessionHandler = context.read<SessionHandler>();
          handler.listenToUserHelpRequests(sessionHandler.currentUser.id);
          return handler;
        },
        child: BlocBuilder<HelpRequestLoadHandler, HelpRequestLoadState>(
          builder: (context, state) {
            final HelpRequestLoadHandler helpRequestLoadHandler =
                context.read<HelpRequestLoadHandler>();
            return ConditionalBuilder(
              condition: helpRequestLoadHandler.userHelpRequests.isNotEmpty,
              builder: (context) {
                return ListView.builder(
                  itemCount: helpRequestLoadHandler.userHelpRequests.length,
                  itemBuilder: (context, index) {
                    final helpRequest =
                        helpRequestLoadHandler.userHelpRequests[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: VolunteenHelpRequestCard(
                        isEditAuth: true,
                        helpRequest: helpRequest,
                        onDelete: () {
                          helpRequestLoadHandler
                              .deleteHelpRequest(helpRequest.id);
                        },
                        onTap: () {
                          context.router.push(
                            HelpRequestDetailRoute(
                              helpRequest: helpRequest,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              fallback: (context) {
                return Center(
                    child:
                        Text(LocaleKeys.my_services_screen_empty_screen.tr()));
              },
            );
          },
        ),
      ),
    );
  }
}

class NewRequestAlertDialogItem extends StatelessWidget {
  final HelpCategory helpCategory;
  final BuildContext alertDialogContext;
  const NewRequestAlertDialogItem({
    super.key,
    required this.helpCategory,
    required this.alertDialogContext,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        alertDialogContext.router.maybePop();
        context.router.push(
          SubmitHelpRequestRoute(
            helpCategory: helpCategory,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: VolunteenColors.vanilla,
        ),
        width: double.infinity,
        height: height * 0.1,
        child: Text(
          StringUtility.getHelpCategoryName(helpCategory, context),
        ),
      ),
    );
  }
}

class HelpRequestsDialog extends StatelessWidget {
  final BuildContext alertDialogContext;
  const HelpRequestsDialog({super.key, required this.alertDialogContext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.my_services_screen_categories.tr(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            alertDialogContext.router.maybePop();
          },
          child: Text(
            LocaleKeys.buttons_close.tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NewRequestAlertDialogItem(
            helpCategory: HelpCategory.elderlyHelp,
            alertDialogContext: alertDialogContext,
          ),
          NewRequestAlertDialogItem(
            helpCategory: HelpCategory.childCare,
            alertDialogContext: alertDialogContext,
          ),
          NewRequestAlertDialogItem(
            helpCategory: HelpCategory.petCare,
            alertDialogContext: alertDialogContext,
          ),
          NewRequestAlertDialogItem(
            helpCategory: HelpCategory.delivery,
            alertDialogContext: alertDialogContext,
          ),
          NewRequestAlertDialogItem(
            helpCategory: HelpCategory.other,
            alertDialogContext: alertDialogContext,
          )
        ],
      ),
    );
  }
}
