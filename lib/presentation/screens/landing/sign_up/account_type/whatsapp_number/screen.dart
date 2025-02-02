import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/business_logic/handler/signup/handler.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class WhatsAppNumberScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final SignupHandler signupHandler;
  final TextEditingController whatsAppNumberTextEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  WhatsAppNumberScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.signupHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 40,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo/logo.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocaleKeys.authentication_whatsapp_screen_message.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  VolunteenTextFormField(
                    labelText: LocaleKeys.authentication_whatsapp_number.tr(),
                    controller: whatsAppNumberTextEditingController,
                    textAlign: TextAlign.center,
                    textInputType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return LocaleKeys.validations_whatsapp.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  VolunteenFilledElevatedButton(
                    text: LocaleKeys.authentication_register.tr(),
                    fontSize: 18,
                    height: 40,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signupHandler.signupVolunteer(
                          name,
                          email,
                          password,
                          whatsAppNumberTextEditingController.text,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
