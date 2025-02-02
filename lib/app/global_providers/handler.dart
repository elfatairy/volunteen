import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/all_donation/handler.dart';
import 'package:volunteen/business_logic/handler/app_language/handler.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/handler/send_notification/handler.dart';

class VolunteenGlobalHandlers extends StatelessWidget {
  final Widget child;
  const VolunteenGlobalHandlers({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionHandler(
            authRepository: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => SendNotificationHandler(),
        ),
        BlocProvider(
          create: (context) => ImageLoaderHandler(
            storageRepository: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) {
            final handler = AllDonationHandler(
              donationRepository: context.read(),
              userRepository: context.read(),
              firebaseMessaging:
                  context.read<SessionHandler>().firebaseMessaging,
            );
            handler.listenToAllDonations(
                context.read<SessionHandler>().currentUser.id);
            return handler;
          },
        ),
        BlocProvider(
          create: (context) => AppLanguageHandler(
            context: context,
          ),
        ),
      ],
      child: child,
    );
  }
}
