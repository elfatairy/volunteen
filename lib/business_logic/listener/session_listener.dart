// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/helper/volunteen_app_page.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/authentication.dart';

class VolunteenSessionAppStateListener extends StatelessWidget {
  final AppRouter router;
  final SessionHandler handler;
  final Widget child;
  VolunteenAppPage last;
  VolunteenSessionAppStateListener({
    Key? key,
    required this.router,
    required this.handler,
    required this.child,
    this.last = VolunteenAppPage.init,
  }) : super(key: key) {
    handler.stream.listen((handler) {
      _newState(handler);
    });
    _newState(handler.state);
  }

  _newState(SessionState newState) {
    VolunteenAppPage current = getVolunteenAppStateBySessionState(newState);
    if (last != current) {
      last = current;
      switch (last) {
        case VolunteenAppPage.authenticated:
          router.replaceAll([const MainRoute()]);
          break;
        case VolunteenAppPage.unauthenticated:
        case VolunteenAppPage.init:
          router.replaceAll([const LandingRoute()]);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
