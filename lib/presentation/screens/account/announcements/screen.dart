import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/announcements/handler.dart';
import 'package:volunteen/data/models/announcement.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(LocaleKeys.account_screen_announcements.tr()),
      ),
      body: BlocProvider(
        create: (context) =>
            AnnouncementsHandler(announcementRepository: context.read())
              ..getAllAnnouncements(),
        child: BlocBuilder<AnnouncementsHandler, AnnouncementsState>(
          builder: (context, state) {
            final List<Announcement> announcements =
                context.read<AnnouncementsHandler>().announcements;
            if (announcements.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final Announcement announcement = announcements[index];
                  return ListTile(
                    title: Text(
                      announcement.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Text(
                      announcement.content,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 5,
                    thickness: 2,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
