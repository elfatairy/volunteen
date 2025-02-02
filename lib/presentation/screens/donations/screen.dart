import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/all_donation/handler.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/donation_abstract.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionHandler sessionHandler = context.read<SessionHandler>();
    final String userId = sessionHandler.currentUser.id;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(LocaleKeys.donations_screen_title.tr()),
        actions: [
          BlocBuilder<SessionHandler, SessionState>(
            builder: (context, state) {
              final bool subsDonation =
                  context.read<SessionHandler>().currentUser.subsDonation;

              final AllDonationHandler donationHandler =
                  context.read<AllDonationHandler>();
              return IconButton(
                onPressed: () {
                  subsDonation
                      ? donationHandler.unsubscribeDonation(userId)
                      : donationHandler.subscribeDonation(userId);
                },
                icon: Icon(
                  subsDonation
                      ? Icons.notifications_active
                      : Icons.notifications_none_sharp,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              context.router.push(SubmitDonationRoute());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<AllDonationHandler, AllDonationState>(
        builder: (context, state) {
          final AllDonationHandler donationHandler =
              context.read<AllDonationHandler>();
          final SessionHandler sessionHandler = context.read();
          final ImageLoaderHandler imageLoaderHandler = context.read();
          final List<Donation> donations = donationHandler.allDonations;
          return ConditionalBuilder(
            condition: donations.isEmpty,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            fallback: (context) {
              return ListView.builder(
                itemCount: donations.length,
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
                          donationHandler.removeFavDonation(
                            sessionHandler.currentUser.id,
                            donations[index].id,
                          );
                        },
                        addMethod: () {
                          donationHandler.addFavDonation(
                            sessionHandler.currentUser.id,
                            donations[index].id,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
