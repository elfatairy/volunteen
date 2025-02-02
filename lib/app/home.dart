import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/user_roles.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'dart:ui' as ui;

@RoutePage()
class MainScreen extends StatelessWidget {
  final String imagesPath = "assets/images/navbar";
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionHandler, SessionState>(
      builder: (context, state) {
        final SessionHandler sessionHandler = context.read<SessionHandler>();
        final List<UserRoles> userRoles = sessionHandler.currentUser.userRoles;
        return Directionality(
          textDirection: context.locale.languageCode == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AutoTabsScaffold(
            routes: getRoutes(userRoles),
            bottomNavigationBuilder: (context, tabsRouter) {
              final routes = getRoutes(userRoles);
              if (routes.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          color: VolunteenColors.lightGrey, width: 1)),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  currentIndex: tabsRouter.activeIndex < routes.length
                      ? tabsRouter.activeIndex
                      : 0,
                  onTap: tabsRouter.setActiveIndex,
                  selectedFontSize: 17,
                  unselectedFontSize: 14,
                  selectedItemColor: VolunteenColors.darkBlue,
                  unselectedItemColor: VolunteenColors.darkBlue,
                  items: List.generate(getRoutes(userRoles).length, (index) {
                    final bool isSelected = tabsRouter.activeIndex == index;
                    return BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? VolunteenColors.babyBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          getImagePathForIndex(index, userRoles),
                          width: 40,
                          height: 40,
                          color: VolunteenColors.darkBlue,
                        ),
                      ),
                      label: getLabelForIndex(
                        index,
                        userRoles,
                        context,
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<PageRouteInfo<dynamic>> getRoutes(
    final List<UserRoles> userRoles,
  ) {
    if (userRoles.contains(UserRoles.volunteer)) {
      return const [
        HomeRoute(),
        HelpRequestsRoute(),
        ServicesRoute(),
        DonationsRoute(),
        AccountRoute(),
      ];
    } else {
      return const [
        HomeRoute(),
        HelpRequestsRoute(),
        DonationsRoute(),
        AccountRoute(),
      ];
    }
  }

  String getImagePathForIndex(int index, List<UserRoles> userRoles) {
    final List<String> paths = [
      '$imagesPath/main.png',
      '$imagesPath/orders.png',
      if (userRoles.contains(UserRoles.volunteer)) '$imagesPath/services.png',
      '$imagesPath/donations.png',
      '$imagesPath/account.png',
    ];
    return paths[index];
  }

  String getLabelForIndex(
    int index,
    List<UserRoles> userRoles,
    BuildContext context,
  ) {
    final List<String> labels = [
      'الرئيسية',
      'طلباتي',
      if (userRoles.contains(UserRoles.volunteer)) 'تطوعاتي',
      'التبرعات',
      'الحساب',
    ];
    final List<String> labelsEn = [
      "Home",
      "My Requests",
      if (userRoles.contains(UserRoles.volunteer)) "Volunteering",
      "Donations",
      "Account",
    ];
    return context.locale.languageCode == 'ar'
        ? labels[index]
        : labelsEn[index];
  }
}
