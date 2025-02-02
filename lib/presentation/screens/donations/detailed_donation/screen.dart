import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/image_loader.dart';
import 'dart:ui' as ui;

@RoutePage()
class DetailedDonationScreen extends StatelessWidget {
  final Donation donation;
  const DetailedDonationScreen({
    super.key,
    required this.donation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          donation.title,
        ),
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
      ),
      body: BlocBuilder<ImageLoaderHandler, ImageLoaderState>(
        builder: (context, state) {
          final ImageLoaderHandler imageLoaderHandler =
              context.read<ImageLoaderHandler>();
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ImageLoaderWidget(
                      id: donation.id,
                      function: () => imageLoaderHandler
                          .getImage('donation/${donation.id}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 15,
                      bottom: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          donation.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          donation.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: VolunteenColors.pink),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                donation.location,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.phone, color: VolunteenColors.pink),
                            SizedBox(width: 8),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: Text(
                                textAlign: context.locale.languageCode == 'ar'
                                    ? TextAlign.right
                                    : TextAlign.left,
                                donation.phoneNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.whatsapp,
                                color: VolunteenColors.pink),
                            SizedBox(width: 8),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: Text(
                                textAlign: context.locale.languageCode == 'ar'
                                    ? TextAlign.right
                                    : TextAlign.left,
                                donation.whatsAppNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
