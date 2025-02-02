import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/signup/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/repositories/authentication.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class AccountTypeScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  const AccountTypeScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupHandler(
        authRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: BlocBuilder<SignupHandler, SignupState>(
          builder: (context, state) {
            final SignupHandler signupHandler = context.read();
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo/logo.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    AccountTypeWidget(
                      onTap: () {
                        signupHandler.signupNormalUser(
                          name,
                          email,
                          password,
                        );
                      },
                      title: LocaleKeys.authentication_user.tr(),
                      imagePath: "assets/images/account_type_screen/user.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AccountTypeWidget(
                      onTap: () {
                        context.router.push(
                          WhatsAppNumberRoute(
                            name: name,
                            email: email,
                            password: password,
                            signupHandler: signupHandler,
                          ),
                        );
                      },
                      title: LocaleKeys.authentication_volunteer.tr(),
                      imagePath:
                          "assets/images/account_type_screen/volunteer.png",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AccountTypeWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final String imagePath;
  const AccountTypeWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: VolunteenColors.pink,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                imagePath,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
