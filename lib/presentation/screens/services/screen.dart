import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/services_screen/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionHandler sessionHandler = context.read<SessionHandler>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(LocaleKeys.volunteering_app_bar_title.tr()),
        actions: [
          BlocProvider(
            create: (context) => ServicesScreenHandler(
              userRepository: context.read(),
              firebaseMessaging: sessionHandler.firebaseMessaging,
            ),
            child: BlocBuilder<SessionHandler, SessionState>(
              builder: (context, state) {
                final String userId = sessionHandler.currentUser.id;
                final bool subsHelpRequest =
                    sessionHandler.currentUser.subsHelpRequest;

                final ServicesScreenHandler servicesScreenHandler =
                    context.read<ServicesScreenHandler>();
                return IconButton(
                  onPressed: () {
                    servicesScreenHandler.toggleSubsDonation(
                      userId,
                      subsHelpRequest ? false : true,
                    );
                  },
                  icon: Icon(
                    subsHelpRequest
                        ? Icons.notifications_active
                        : Icons.notifications_none_sharp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServicesScreenItem(
            helpCategory: HelpCategory.elderlyHelp,
            onTap: () {
              context.router.push(
                ServicesListRoute(
                  helpCategory: HelpCategory.elderlyHelp,
                ),
              );
            },
          ),
          ServicesScreenItem(
            helpCategory: HelpCategory.childCare,
            onTap: () {
              context.router.push(
                ServicesListRoute(
                  helpCategory: HelpCategory.childCare,
                ),
              );
            },
          ),
          ServicesScreenItem(
            helpCategory: HelpCategory.petCare,
            onTap: () {
              context.router.push(
                ServicesListRoute(
                  helpCategory: HelpCategory.petCare,
                ),
              );
            },
          ),
          ServicesScreenItem(
            helpCategory: HelpCategory.delivery,
            onTap: () {
              context.router.push(
                ServicesListRoute(
                  helpCategory: HelpCategory.delivery,
                ),
              );
            },
          ),
          ServicesScreenItem(
            helpCategory: HelpCategory.other,
            onTap: () {
              context.router.push(
                ServicesListRoute(
                  helpCategory: HelpCategory.other,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServicesScreenItem extends StatelessWidget {
  final HelpCategory helpCategory;
  final Function onTap;
  const ServicesScreenItem({
    super.key,
    required this.helpCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return InkWell(
      onTap: () => onTap(),
      child: Stack(
        alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(15),
              color: VolunteenColors.lightGrey,
            ),
            child: Text(
              StringUtility.getHelpCategoryName(
                helpCategory,
                context,
              ),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: VolunteenColors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.grey[400]!),
            ),
            child: Image.asset(
              StringUtility.getHelpCategoryImagePath(
                helpCategory,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
