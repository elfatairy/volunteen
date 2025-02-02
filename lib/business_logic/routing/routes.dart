// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/app/home.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/handler/signup/handler.dart';
import 'package:volunteen/business_logic/routing/route_guards/routing_guard.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/screens/account/announcements/screen.dart';
import 'package:volunteen/presentation/screens/account/contact_us/screen.dart';
import 'package:volunteen/presentation/screens/account/empty_screen.dart';
import 'package:volunteen/presentation/screens/account/feedback/screen.dart';
import 'package:volunteen/presentation/screens/account/saved_donations/empty_screen.dart';
import 'package:volunteen/presentation/screens/account/saved_donations/screen.dart';
import 'package:volunteen/presentation/screens/account/screen.dart';
import 'package:volunteen/presentation/screens/account/supporters/screen.dart';
import 'package:volunteen/presentation/screens/account/user_donation/empty_screen.dart';
import 'package:volunteen/presentation/screens/account/user_donation/screen.dart';
import 'package:volunteen/presentation/screens/donations/detailed_donation/screen.dart';
import 'package:volunteen/presentation/screens/donations/empty_screen.dart';
import 'package:volunteen/presentation/screens/donations/screen.dart';
import 'package:volunteen/presentation/screens/donations/submit_donation/screen.dart';
import 'package:volunteen/presentation/screens/help_requests/detailed_request_screen/screen.dart';
import 'package:volunteen/presentation/screens/help_requests/empty_screen.dart';
import 'package:volunteen/presentation/screens/home/empty_screen.dart';
import 'package:volunteen/presentation/screens/home/helping_hands/screen.dart';
import 'package:volunteen/presentation/screens/home/new_helping_hand/screen.dart';
import 'package:volunteen/presentation/screens/home/screen.dart';
import 'package:volunteen/presentation/screens/home/submit_help_request/screen.dart';
import 'package:volunteen/presentation/screens/help_requests/screen.dart';
import 'package:volunteen/presentation/screens/landing/empty_screen.dart';
import 'package:volunteen/presentation/screens/landing/login/screen.dart';
import 'package:volunteen/presentation/screens/landing/screen.dart';
import 'package:volunteen/presentation/screens/landing/sign_up/account_type/empty_screen.dart';
import 'package:volunteen/presentation/screens/landing/sign_up/account_type/screen.dart';
import 'package:volunteen/presentation/screens/landing/sign_up/account_type/whatsapp_number/screen.dart';
import 'package:volunteen/presentation/screens/landing/sign_up/empty_screen.dart';
import 'package:volunteen/presentation/screens/landing/sign_up/screen.dart';
import 'package:volunteen/presentation/screens/services/empty_screen.dart';
import 'package:volunteen/presentation/screens/services/screen.dart';
import 'package:volunteen/presentation/screens/services/services_list/empty_screen.dart';
import 'package:volunteen/presentation/screens/services/services_list/service_detailed/screen.dart';
import 'package:volunteen/presentation/screens/services/services_list/services_list.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();
  final SessionHandler sessionHandler;

  AppRouter({required this.sessionHandler});
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/landing',
          page: LandingEmptyRoute.page,
          children: [
            AutoRoute(
              path: '',
              initial: true,
              page: LandingRoute.page,
            ),
            AutoRoute(
              path: 'login',
              page: LoginRoute.page,
            ),
            AutoRoute(
              path: 'signup',
              page: SignUpEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: SignUpRoute.page,
                ),
                AutoRoute(
                  path: 'account_type',
                  page: AccountTypeEmptyRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      initial: true,
                      page: AccountTypeRoute.page,
                    ),
                    AutoRoute(
                      path: 'whatsapp_number',
                      page: WhatsAppNumberRoute.page,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        AutoRoute(
          path: '/',
          initial: true,
          page: MainRoute.page,
          guards: [RoutingGuard(sessionHandler: sessionHandler)],
          children: [
            AutoRoute(
              path: 'home',
              page: HomeEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: HomeRoute.page,
                ),
                AutoRoute(
                  path: 'submit_help_request',
                  page: SubmitHelpRequestRoute.page,
                ),
                AutoRoute(
                  path: 'helping_hands',
                  page: HelpingHandsRoute.page,
                ),
                AutoRoute(
                  path: 'new_helping_hand',
                  page: NewHelpingHandRoute.page,
                ),
                AutoRoute(
                  path: 'submit_donation',
                  page: SubmitDonationRoute.page,
                ),
                AutoRoute(
                  path: 'detailed_donation',
                  page: DetailedDonationRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'help_requests',
              page: HelpRequestsEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: HelpRequestsRoute.page,
                ),
                AutoRoute(
                  path: 'detailed_help_request',
                  page: HelpRequestDetailRoute.page,
                ),
                AutoRoute(
                  path: 'submit_help_request',
                  page: SubmitHelpRequestRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'donations',
              page: DonationsEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: DonationsRoute.page,
                ),
                AutoRoute(
                  path: 'submit_donation',
                  page: SubmitDonationRoute.page,
                ),
                AutoRoute(
                  path: 'detailed_donation',
                  page: DetailedDonationRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'account',
              page: AccountEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: AccountRoute.page,
                ),
                AutoRoute(
                  path: 'user_donation',
                  page: UserDonationEmptyRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      initial: true,
                      page: UserDonationRoute.page,
                    ),
                    AutoRoute(
                      path: 'detailed_donation',
                      page: DetailedDonationRoute.page,
                    )
                  ],
                ),
                AutoRoute(
                  path: 'saved_donations',
                  page: SavedDonationsEmptyRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      initial: true,
                      page: SavedDonationsRoute.page,
                    ),
                    AutoRoute(
                      path: 'detailed_donation',
                      page: DetailedDonationRoute.page,
                    )
                  ],
                ),
                AutoRoute(
                  path: 'announcements',
                  page: AnnouncementsRoute.page,
                ),
                AutoRoute(
                  path: 'feedback',
                  page: FeedbackRoute.page,
                ),
                AutoRoute(
                  path: 'contact_us',
                  page: ContactUsRoute.page,
                ),
                AutoRoute(
                  path: 'supporters',
                  page: SupportesRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'services',
              page: ServicesEmptyRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  initial: true,
                  page: ServicesRoute.page,
                ),
                AutoRoute(
                  path: 'services_list',
                  page: ServicesListEmptyRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      page: ServicesListRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      path: 'service_detailed',
                      page: ServiceDetailedRoute.page,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ];
}
