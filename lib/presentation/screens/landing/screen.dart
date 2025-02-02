import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/change_language.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo/logo.png"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              child: VolunteenFilledElevatedButton(
                text: LocaleKeys.authentication_login.tr(),
                fontSize: 18,
                height: 40,
                onPressed: () {
                  context.router.push(LoginRoute());
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: VolunteenFilledElevatedButton(
                text: LocaleKeys.authentication_signup.tr(),
                fontSize: 18,
                height: 40,
                onPressed: () {
                  context.router.push(SignUpRoute());
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const VolunteenChangeLanguage(),
          ],
        ),
      ),
    );
  }
}
