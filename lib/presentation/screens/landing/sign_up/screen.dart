import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'dart:ui' as ui;

@RoutePage()
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 20 + MediaQuery.of(context).padding.top,
            bottom: 20,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo/logo.png"),
                  const SizedBox(
                    height: 5,
                  ),
                  VolunteenTextFormField(
                    labelText: LocaleKeys.authentication_name.tr(),
                    controller: nameTextEditingController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return LocaleKeys.validations_name.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  VolunteenTextFormField(
                    labelText: LocaleKeys.authentication_email.tr(),
                    controller: emailTextEditingController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return LocaleKeys.validations_email.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  VolunteenTextFormField(
                    labelText: LocaleKeys.authentication_password.tr(),
                    controller: passwordTextEditingController,
                    isObscure: true,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return LocaleKeys.validations_password.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  VolunteenTextFormField(
                    labelText: LocaleKeys.authentication_confirm_password.tr(),
                    controller: confirmPasswordTextEditingController,
                    isObscure: true,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return LocaleKeys.validations_confirm_password.tr();
                      }
                      if (input != passwordTextEditingController.text) {
                        return LocaleKeys.validations_password_match.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  VolunteenFilledElevatedButton(
                    text: LocaleKeys.authentication_signup.tr(),
                    fontSize: 18,
                    height: 40,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.router.push(
                          AccountTypeRoute(
                            name: nameTextEditingController.text,
                            email: emailTextEditingController.text,
                            password: passwordTextEditingController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
