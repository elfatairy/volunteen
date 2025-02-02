import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/data/enums/authentication.dart';

VolunteenAppPage getVolunteenAppStateBySessionState(SessionState state) {
  if (state is SessionStateAuthenticated) {
    return VolunteenAppPage.authenticated;
  } else if (state is SessionStateUnauthenticated) {
    return VolunteenAppPage.unauthenticated;
  } else {
    return VolunteenAppPage.init;
  }
}
