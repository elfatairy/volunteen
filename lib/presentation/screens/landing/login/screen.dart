import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/login/handler.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'dart:ui' as ui;

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginHandler(authRepository: context.read()),
          child: BlocBuilder<LoginHandler, LoginState>(
            builder: (context, state) {
              final LoginHandler loginHandler = context.read();
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20 + MediaQuery.of(context).padding.top,
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
                        state is LoginStateLoading
                            ? const CircularProgressIndicator()
                            : VolunteenFilledElevatedButton(
                                text: LocaleKeys.authentication_login.tr(),
                                fontSize: 18,
                                height: 40,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    loginHandler.logInWithCredentials(
                                      emailTextEditingController.text,
                                      passwordTextEditingController.text,
                                    );
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
