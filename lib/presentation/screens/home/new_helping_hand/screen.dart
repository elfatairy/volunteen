import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/new_helping_hand/handler.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/new_helping_hand.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class NewHelpingHandScreen extends StatefulWidget {
  NewHelpingHandScreen({super.key});

  @override
  State<NewHelpingHandScreen> createState() => _NewHelpingHandScreenState();
}

class _NewHelpingHandScreenState extends State<NewHelpingHandScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController whatsAppNumberTextEditingController =
      TextEditingController();
  final TextEditingController jobDescriptionTextEditingController =
      TextEditingController();
  final TextEditingController numberTextEditingController =
      TextEditingController();
  HelpingHandCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewHelpingHandHandler(
        newHelpingHandsRepository: context.read(),
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: VolunteenColors.white,
          backgroundColor: VolunteenColors.pink,
          title: Text(
            LocaleKeys.new_helping_hand_screen_app_bar_title.tr(),
            style: TextStyle(
              color: VolunteenColors.white,
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: BlocBuilder<NewHelpingHandHandler, NewHelpingHandState>(
                builder: (context, state) {
                  final NewHelpingHandHandler newHelpingHandHandler =
                      context.read();
                  return Column(
                    children: [
                      VolunteenTextFormField(
                        labelText: LocaleKeys.authentication_name.tr(),
                        controller: nameTextEditingController,
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
                        labelText: LocaleKeys.authentication_email.tr(),
                        controller: emailTextEditingController,
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
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.new_helping_hand_screen_category.tr(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<HelpingHandCategory>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                        ),
                        hint: Text(LocaleKeys
                            .new_helping_hand_screen_choose_category
                            .tr()),
                        value: selectedCategory,
                        onChanged: (HelpingHandCategory? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: HelpingHandCategory.values
                            .map((HelpingHandCategory category) {
                          return DropdownMenuItem<HelpingHandCategory>(
                            value: category,
                            child: Text(
                              StringUtility.getHelpingHandCategoryName(
                                category,
                                context,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return LocaleKeys
                                .new_helping_hand_screen_please_choose_category
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText: LocaleKeys.new_helping_hand_screen_job.tr(),
                        controller: jobDescriptionTextEditingController,
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
                            .new_helping_hand_screen_phone_number
                            .tr(),
                        controller: numberTextEditingController,
                        textInputType: TextInputType.number,
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
                            .new_helping_hand_screen_whats_app_number
                            .tr(),
                        controller: whatsAppNumberTextEditingController,
                        textInputType: TextInputType.number,
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
                        condition: false,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        fallback: (context) {
                          return VolunteenFilledElevatedButton(
                            text: LocaleKeys.buttons_send.tr(),
                            onPressed: () async {
                              if (formKey.currentState!.validate() ||
                                  selectedCategory != null) {
                                await newHelpingHandHandler
                                    .createNewHelpingHand(
                                  NewHelpingHand(
                                    name: nameTextEditingController.text,
                                    email: emailTextEditingController.text,
                                    helpingHandCategory: selectedCategory!,
                                    jobDescription:
                                        jobDescriptionTextEditingController
                                            .text,
                                    phoneNumber:
                                        numberTextEditingController.text,
                                    whatsAppNumber:
                                        whatsAppNumberTextEditingController
                                            .text,
                                  ),
                                );
                                clearTextEditingControllers();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearTextEditingControllers() {
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    whatsAppNumberTextEditingController.clear();
    numberTextEditingController.clear();
    jobDescriptionTextEditingController.clear();
  }
}
