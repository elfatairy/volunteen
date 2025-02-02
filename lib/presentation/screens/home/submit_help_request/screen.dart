// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/help_request/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/presentation/widgets/volunteen_date_picker.dart';
import 'package:volunteen/presentation/widgets/volunteen_time_picker.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class SubmitHelpRequestScreen extends StatelessWidget {
  HelpCategory helpCategory;
  SubmitHelpRequestScreen({super.key, required this.helpCategory});

  final formKey = GlobalKey<FormState>();
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController descriptionTextEditingController =
      TextEditingController();
  final TextEditingController locationTextEditingController =
      TextEditingController();
  final TextEditingController locationInDetailsTextEditingController =
      TextEditingController();
  final TextEditingController dayTextEditingController =
      TextEditingController();
  final TextEditingController hourTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController whatsAppNumberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitHelpRequestHandler(
        helpRequestRepository: context.read(),
        sendNotificationHandler: context.read(),
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: VolunteenColors.white,
          backgroundColor: VolunteenColors.pink,
          title: Text(
            StringUtility.getHelpCategoryName(
              helpCategory,
              context,
            ),
            style: const TextStyle(
              color: VolunteenColors.white,
            ),
          ),
        ),
        body: BlocBuilder<SubmitHelpRequestHandler, HelpRequestState>(
          builder: (context, state) {
            final SubmitHelpRequestHandler handler =
                context.read<SubmitHelpRequestHandler>();
            final SessionHandler sessionHandler =
                context.read<SessionHandler>();
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      VolunteenTextFormField(
                        labelText:
                            LocaleKeys.submit_help_request_screen_title.tr(),
                        controller: titleTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText: LocaleKeys
                            .submit_help_request_screen_description
                            .tr(),
                        controller: descriptionTextEditingController,
                        textInputType: TextInputType.multiline,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText:
                            LocaleKeys.submit_help_request_screen_location.tr(),
                        controller: locationTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText: LocaleKeys
                            .submit_help_request_screen_location_in_details
                            .tr(),
                        controller: locationInDetailsTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenDatePickerField(
                        labelText:
                            LocaleKeys.submit_help_request_screen_day.tr(),
                        controller: dayTextEditingController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTimePickerField(
                        labelText:
                            LocaleKeys.submit_help_request_screen_hour.tr(),
                        controller: hourTextEditingController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText: LocaleKeys
                            .submit_help_request_screen_phone_number
                            .tr(),
                        controller: phoneNumberTextEditingController,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText: LocaleKeys
                            .submit_help_request_screen_whatsapp_number
                            .tr(),
                        controller: whatsAppNumberTextEditingController,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.validations_enter_needed_field
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is HelpRequestStateSubmitLoading,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        fallback: (context) {
                          return VolunteenFilledElevatedButton(
                            text: LocaleKeys.buttons_send.tr(),
                            onPressed: () {
                              handler
                                  .createHelpRequest(
                                HelpRequest(
                                  id: '',
                                  title: titleTextEditingController.text,
                                  description:
                                      descriptionTextEditingController.text,
                                  category: helpCategory,
                                  location: locationTextEditingController.text,
                                  locationInDetails:
                                      locationInDetailsTextEditingController
                                          .text,
                                  phoneNumber:
                                      phoneNumberTextEditingController.text,
                                  whatsAppNumber:
                                      whatsAppNumberTextEditingController.text,
                                  day: dayTextEditingController.text,
                                  hour: hourTextEditingController.text,
                                  requestedUserId:
                                      sessionHandler.currentUser.id,
                                  helpingUserId: null,
                                ),
                              )
                                  .then(
                                (value) {
                                  formKey.currentState!.reset();
                                  clearTextEditingControllers();
                                },
                              );
                            },
                          );
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
    );
  }

  void clearTextEditingControllers() {
    titleTextEditingController.clear();
    descriptionTextEditingController.clear();
    locationTextEditingController.clear();
    locationInDetailsTextEditingController.clear();
    dayTextEditingController.clear();
    hourTextEditingController.clear();
    phoneNumberTextEditingController.clear();
    whatsAppNumberTextEditingController.clear();
  }
}
