// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteen/business_logic/handler/account_screen/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/user_roles.dart';
import 'package:volunteen/data/models/share_app.dart';
import 'package:volunteen/presentation/widgets/change_language.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  final String imagesPath = "assets/images/account_screen";
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = context.read<SessionHandler>().currentUser.name;
    return BlocProvider(
      create: (context) => AccountScreenHandler(
        authenticationRepository: context.read(),
        shareAppRepository: context.read(),
        emergencyRepository: context.read(),
      )
        ..getShareAppData()
        ..getEmergencyNumber(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<AccountScreenHandler, AccountScreenState>(
            builder: (context, state) {
              final AccountScreenHandler accountScreenHandler = context.read();
              final List<UserRoles> userRoles =
                  context.read<SessionHandler>().currentUser.userRoles;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Text(
                            (userName.isNotEmpty) ? userName[0] : '',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            LocaleKeys.account_screen_app_bar_title.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.blue,
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_my_donations.tr(),
                    imagePath: '$imagesPath/ads_donations.png',
                    function: () {
                      context.router.push(const UserDonationRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_saved_donations.tr(),
                    imagePath: '$imagesPath/saved_ads.png',
                    function: () {
                      context.router.push(const SavedDonationsRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_announcements.tr(),
                    imagePath: '$imagesPath/important_announcements.png',
                    function: () {
                      context.router.push(const AnnouncementsRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_account_type.tr(),
                    subTitle: getAccountType(userRoles),
                    imagePath: '$imagesPath/account_type.png',
                    function: () {},
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_supportes.tr(),
                    imagePath: '$imagesPath/app_donators.png',
                    function: () {
                      context.router.push(const SupportesRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_contact_us.tr(),
                    imagePath: '$imagesPath/contact_us.png',
                    function: () {
                      context.router.push(const ContactUsRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_feedback.tr(),
                    imagePath: '$imagesPath/share_opinion.png',
                    function: () {
                      context.router.push(FeedbackRoute());
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_share_app.tr(),
                    imagePath: '$imagesPath/share_app.png',
                    function: () {
                      Share.share(getShareLink(
                          context, accountScreenHandler.shareApp!));
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_chosen_language.tr(),
                    subTitle: LocaleKeys.account_screen_change_language.tr(),
                    imagePath: '$imagesPath/change_lang.png',
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const VolunteenChangeLanguageAlertDialog();
                        },
                      );
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_emergency.tr(),
                    imagePath: '$imagesPath/emergency.png',
                    function: () async {
                      final Uri phoneUri = Uri(
                        scheme: 'tel',
                        path: accountScreenHandler.emergencyNumber!,
                      );
                      if (await canLaunchUrl(phoneUri)) {
                        await launchUrl(phoneUri);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تعذر فتح تطبيق الهاتف'),
                          ),
                        );
                      }
                    },
                  ),
                  AccountItemsWidget(
                    title: LocaleKeys.account_screen_logout.tr(),
                    imagePath: '$imagesPath/sign_out.png',
                    function: () {
                      accountScreenHandler.signOut();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String getAccountType(final List<UserRoles> userRoles) {
    if (userRoles.contains(UserRoles.volunteer)) {
      return LocaleKeys.account_screen_account_type_volunteer.tr();
    } else {
      return LocaleKeys.account_screen_account_type_user.tr();
    }
  }

  String getShareLink(
    final BuildContext context,
    final ShareApp shareApp,
  ) {
    String message;
    String link;
    if (context.locale.languageCode == 'ar') {
      message = shareApp.messageAr;
    } else {
      message = shareApp.messageEn;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      link = shareApp.appLinkiOS;
    } else {
      link = shareApp.appLinkAndroid;
    }
    return '$message $link';
  }
}

class AccountItemsWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String imagePath;
  Function? function;
  AccountItemsWidget(
      {super.key,
      required this.title,
      this.subTitle,
      required this.imagePath,
      this.function});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => function!(),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          imagePath,
          scale: 1,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          : Container(),
    );
  }
}
