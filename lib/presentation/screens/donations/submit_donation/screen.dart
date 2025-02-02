import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volunteen/business_logic/handler/create_donation/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class SubmitDonationScreen extends StatefulWidget {
  SubmitDonationScreen({super.key});

  @override
  State<SubmitDonationScreen> createState() => _SubmitDonationScreenState();
}

class _SubmitDonationScreenState extends State<SubmitDonationScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleTextEditingController =
      TextEditingController();

  final TextEditingController descriptionTextEditingController =
      TextEditingController();

  final TextEditingController locationTextEditingController =
      TextEditingController();

  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  final TextEditingController whatsAppNumberTextEditingController =
      TextEditingController();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(LocaleKeys.submit_donation_screen_title.tr()),
      ),
      body: BlocProvider(
        create: (context) => CreateDonationHandler(
          donationRepository: context.read(),
          sendNotificationHandler: context.read(),
          storageRepository: context.read(),
        ),
        child: Form(
          key: formKey,
          child: BlocBuilder<CreateDonationHandler, CreateDonationState>(
            builder: (context, state) {
              final CreateDonationHandler createDonationHandler =
                  context.read<CreateDonationHandler>();
              final String userId =
                  context.read<SessionHandler>().currentUser.id;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VolunteenTextFormField(
                        labelText:
                            LocaleKeys.submit_donation_screen_product.tr(),
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
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: selectedImage == null
                              ? Center(
                                  child: Text(
                                    LocaleKeys.submit_donation_screen_choose_pic
                                        .tr(),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      VolunteenTextFormField(
                        labelText:
                            LocaleKeys.submit_donation_screen_description.tr(),
                        controller: descriptionTextEditingController,
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
                            LocaleKeys.submit_donation_screen_location.tr(),
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
                        labelText:
                            LocaleKeys.submit_donation_screen_phone_number.tr(),
                        textInputType: TextInputType.phone,
                        controller: phoneNumberTextEditingController,
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
                            .submit_donation_screen_whatsapp_number
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
                        condition: state is CreateDonationHandlerStateLoading,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        fallback: (context) {
                          return VolunteenFilledElevatedButton(
                            text: LocaleKeys.buttons_send.tr(),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final Donation donation = Donation(
                                  id: '',
                                  title: titleTextEditingController.text,
                                  description:
                                      descriptionTextEditingController.text,
                                  location: locationTextEditingController.text,
                                  phoneNumber:
                                      phoneNumberTextEditingController.text,
                                  whatsAppNumber:
                                      whatsAppNumberTextEditingController.text,
                                  userId: userId,
                                );

                                await createDonationHandler.createDonation(
                                    donation, selectedImage);

                                formKey.currentState!.reset();
                                setState(() {
                                  selectedImage = null;
                                });
                                clearTextEditingControllers();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadImage(
    final BuildContext context,
    final String donationId,
  ) async {
    if (selectedImage != null) {
      await context
          .read<CreateDonationHandler>()
          .uploadDonationImage(donationId, selectedImage!);
    }
  }

  void clearTextEditingControllers() {
    titleTextEditingController.clear();
    descriptionTextEditingController.clear();
    locationTextEditingController.clear();
    phoneNumberTextEditingController.clear();
    whatsAppNumberTextEditingController.clear();
  }
}
