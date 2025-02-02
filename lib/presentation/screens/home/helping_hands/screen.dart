// ignore_for_file: deprecated_member_use, use_build_context_synchronously, use_super_parameters, library_private_types_in_public_api

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteen/business_logic/handler/helping_hand/handler.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/helping_hand.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';
import 'package:cached_network_image/cached_network_image.dart';

@RoutePage()
class HelpingHandsScreen extends StatelessWidget {
  final HelpingHandCategory helpingHandCategory;
  const HelpingHandsScreen({
    super.key,
    required this.helpingHandCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(StringUtility.getHelpingHandCategoryName(
          helpingHandCategory,
          context,
        )),
      ),
      body: BlocProvider(
        create: (context) => HelpingHandHandler(
          helpingHandRepository: context.read(),
          storageRepository: context.read(),
        )..getHelpingHandsForCategory(helpingHandCategory),
        child: BlocBuilder<HelpingHandHandler, HelpingHandState>(
          builder: (context, state) {
            final HelpingHandHandler helpingHandHandler =
                context.read<HelpingHandHandler>();
            if (helpingHandHandler.helpingHands.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: helpingHandHandler.helpingHands.length,
              itemBuilder: (context, index) {
                final HelpingHand helpingHand =
                    helpingHandHandler.helpingHands[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: VolunteenColors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: kElevationToShadow[8],
                    border: Border.all(
                      color: Colors.black,
                      width: 0.3,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200000),
                          child: HelpingHandWidget(
                            helpingHandId: helpingHand.id,
                            helpingHandCategory: helpingHandCategory,
                            helpingHandHandler: helpingHandHandler,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.locale.languageCode == 'ar'
                                  ? helpingHand.nameAr
                                  : helpingHand.nameEn,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              context.locale.languageCode == 'ar'
                                  ? helpingHand.specialityAr
                                  : helpingHand.specialityEn,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                whatsapp(helpingHand.number);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.message_rounded,
                                          color: VolunteenColors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          LocaleKeys.social_media_whatsApp.tr(),
                                          style: TextStyle(
                                              color: VolunteenColors.white),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  whatsapp(
    final String contact,
  ) async {
    String text = '';
    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }
}

class HelpingHandWidget extends StatefulWidget {
  final String helpingHandId;
  final HelpingHandCategory helpingHandCategory;
  final HelpingHandHandler helpingHandHandler;

  const HelpingHandWidget({
    required this.helpingHandId,
    required this.helpingHandCategory,
    required this.helpingHandHandler,
    Key? key,
  }) : super(key: key);

  @override
  _HelpingHandWidgetState createState() => _HelpingHandWidgetState();
}

class _HelpingHandWidgetState extends State<HelpingHandWidget> {
  Future<String>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _getHelpingHandImage();
  }

  Future<String> _getHelpingHandImage() {
    return widget.helpingHandHandler.getHelpingHandImage(
      widget.helpingHandId,
      widget.helpingHandCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          final String helpingHandLink = snapshot.data ?? '';
          return CachedNetworkImage(
            imageUrl: helpingHandLink,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        }
      },
    );
  }
}
