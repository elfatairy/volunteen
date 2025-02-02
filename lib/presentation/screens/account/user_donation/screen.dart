import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/handler/user_donation/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/donation_abstract.dart';
import 'package:volunteen/translation/locale_keys.g.dart';

@RoutePage()
class UserDonationScreen extends StatelessWidget {
  const UserDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionHandler sessionHandler = context.read<SessionHandler>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.router.replaceAll([AccountRoute()]);
          },
        ),
        title: Text(LocaleKeys.account_screen_my_donations.tr()),
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
      ),
      body: BlocProvider(
        create: (context) {
          final handler = UserDonationHandler(
            donationRepository: context.read(),
            storageRepository: context.read(),
          );
          handler.listenToUserDonations(sessionHandler.currentUser.id);
          return handler;
        },
        child: BlocBuilder<UserDonationHandler, UserDonationState>(
          builder: (context, state) {
            final UserDonationHandler userDonationHandler =
                context.read<UserDonationHandler>();
            final ImageLoaderHandler imageLoaderHandler = context.read();
            final List<Donation> donations = userDonationHandler.userDonations;
            return ConditionalBuilder(
              condition: userDonationHandler.userDonations.isEmpty,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              fallback: (context) {
                return ListView.builder(
                  itemCount: userDonationHandler.userDonations.length,
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
                          context.router.push(DetailedDonationRoute(
                              donation: donations[index]));
                        },
                        child: DonationAbstract(
                          id: donation.id,
                          title: donation.title,
                          description: donation.description,
                          location: donation.location,
                          function: () => imageLoaderHandler
                              .getImage('donation/${donation.id}'),
                          isForDelete: true,
                          deleteMethod: () {
                            userDonationHandler.deleteDonation(donation.id);
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
      ),
    );
  }
}
