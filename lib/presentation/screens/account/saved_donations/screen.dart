import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/handler/saved_donations/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/donation_abstract.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class SavedDonationsScreen extends StatelessWidget {
  const SavedDonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionHandler sessionHandler = context.read();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.router.replaceAll([AccountRoute()]);
          },
        ),
        title: Text(LocaleKeys.account_screen_saved_donations.tr()),
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
      ),
      body: BlocProvider(
        create: (context) => SavedDonationsHandler(
          userRepository: context.read(),
          donationRepository: context.read(),
        )..getDonations(sessionHandler.currentUser.savedDonations),
        child: BlocBuilder<SavedDonationsHandler, SavedDonationsState>(
          builder: (context, state) {
            final SavedDonationsHandler savedDonationsHandler = context.read();
            final List<Donation> donations = savedDonationsHandler.allDonations;
            final ImageLoaderHandler imageLoaderHandler = context.read();
            if (savedDonationsHandler.allDonations.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: savedDonationsHandler.allDonations.length,
              itemBuilder: (context, index) {
                final Donation donation = donations[index];
                return Container(
                  key: ValueKey(donation.id),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: VolunteenColors.lightGrey,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.router.push(
                          DetailedDonationRoute(donation: donations[index]));
                    },
                    child: DonationAbstract(
                      id: donation.id,
                      title: donation.title,
                      description: donation.description,
                      location: donation.location,
                      function: () => imageLoaderHandler
                          .getImage('donation/${donation.id}'),
                      isFav: sessionHandler.currentUser.savedDonations
                          .contains(donation.id),
                      deleteMethod: () {
                        savedDonationsHandler.removeFavDonation(
                            sessionHandler.currentUser.id, donation.id);
                      },
                      addMethod: () {
                        savedDonationsHandler.addFavDonation(
                            sessionHandler.currentUser.id, donations[index].id);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
