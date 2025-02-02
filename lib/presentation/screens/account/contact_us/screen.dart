// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/contact_us/handler.dart';
import 'package:volunteen/data/models/contact_us.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;

import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  void _launchFacebook(String pageUrl) async {
    final Uri facebookUri = Uri.parse('fb://page/$pageUrl');
    final Uri browserUri = Uri.parse('https://www.facebook.com/$pageUrl');

    if (await canLaunchUrl(facebookUri)) {
      await launchUrl(facebookUri);
    } else if (await canLaunchUrl(browserUri)) {
      await launchUrl(browserUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsHandler(
        contactUsRepository: context.read(),
      )..getContactUs(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.account_screen_contact_us.tr()),
          foregroundColor: VolunteenColors.white,
          backgroundColor: VolunteenColors.pink,
        ),
        body: BlocBuilder<ContactUsHandler, ContactUsState>(
          builder: (context, state) {
            final ContactUs? contactUs =
                context.read<ContactUsHandler>().contactUs;
            if (contactUs == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.contacts_us_screen_we_are_here.tr(),
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                  ContactItem(
                    icon: Icons.phone,
                    label: contactUs.number,
                    onTap: () => _launchPhone(contactUs.number),
                  ),
                  const SizedBox(height: 16),
                  ContactItem(
                    icon: Icons.email,
                    label: contactUs.email,
                    onTap: () => _launchEmail(contactUs.email),
                  ),
                  const SizedBox(height: 16),
                  ContactItem(
                    icon: FontAwesomeIcons.whatsapp,
                    itemColor: Colors.green,
                    label: LocaleKeys.social_media_whatsApp.tr(),
                    onTap: () => _launchWhatsApp(contactUs.whatsapp),
                  ),
                  const SizedBox(height: 16),
                  ContactItem(
                    icon: Icons.facebook,
                    itemColor: Colors.blue,
                    label: LocaleKeys.social_media_facebook.tr(),
                    onTap: () => _launchFacebook(contactUs.facebook),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  Color? itemColor;

  ContactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: VolunteenColors.pink, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: itemColor ?? VolunteenColors.pink,
              size: 45,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Text(
                  textAlign: context.locale.languageCode == 'ar'
                      ? TextAlign.right
                      : TextAlign.left,
                  label,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
