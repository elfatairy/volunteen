import 'package:auto_route/auto_route.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/helper/volunteen_app_page.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/authentication.dart';

class RoutingGuard extends AutoRouteGuard {
  final SessionHandler sessionHandler;

  RoutingGuard({
    required this.sessionHandler,
  });

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    switch (getVolunteenAppStateBySessionState(sessionHandler.state)) {
      case VolunteenAppPage.authenticated:
        resolver.next(true);
        break;
      case VolunteenAppPage.unauthenticated:
      case VolunteenAppPage.init:
        router.replaceAll([const LandingRoute()]);
        resolver.next(false);
        break;
    }
  }
}
