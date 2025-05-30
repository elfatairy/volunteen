import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/all_donation/handler.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/image_loader.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  static const String imagesPath = "assets/images/main_screen";
  static const String helpRequestsImagesPath = "$imagesPath/help_requests";
  static const String helpingHandsImagesPath = "$imagesPath/helping_hands";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "$imagesPath/main.png",
              width: screenWidth * 0.4,
              height: screenHeight * 0.1,
            ),
            const Expanded(child: SizedBox()),
            const MainScreenCountryDropDownMenu(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const MainScreenSlider(sliderImagesPath: imagesPath),
              MainScreenRequestServices(
                screenWidth: screenWidth,
                helpRequestsImagesPath: helpRequestsImagesPath,
              ),
              const SizedBox(height: 10),
              MainScreenRegisterDonation(
                screenWidth: screenWidth,
                mainScreenImagesPath: imagesPath,
              ),
              const SizedBox(height: 10),
              MainScreenUsersDonations(
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 10),
              MainScreenHelpingHands(
                screenWidth: screenWidth,
                helpingHandsImagesPath: helpingHandsImagesPath,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreenSlider extends StatelessWidget {
  final String sliderImagesPath;
  const MainScreenSlider({
    super.key,
    required this.sliderImagesPath,
  });

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    return CarouselSlider(
      items: [
        Image.asset('$sliderImagesPath/slider/$languageCode/1.png'),
        Image.asset('$sliderImagesPath/slider/$languageCode/2.png'),
        Image.asset('$sliderImagesPath/slider/$languageCode/3.png'),
        Image.asset('$sliderImagesPath/slider/$languageCode/4.png'),
        Image.asset('$sliderImagesPath/slider/$languageCode/5.png'),
        Image.asset('$sliderImagesPath/slider/$languageCode/6.png'),
      ],
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}

class MainScreenRequestServices extends StatelessWidget {
  final double screenWidth;
  final String helpRequestsImagesPath;
  const MainScreenRequestServices(
      {super.key,
      required this.screenWidth,
      required this.helpRequestsImagesPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VoluteenMainScreenHeadingItem(
            title: LocaleKeys.home_request_service.tr(),
            lineWidth: context.locale.languageCode == 'ar'
                ? screenWidth * 0.28
                : screenWidth * 0.35,
          ),
          const SizedBox(
            height: 10,
          ),
          VolunteenMainScreenHelpRequestRow(
            helpRequestsImagesPath: helpRequestsImagesPath,
          ),
        ],
      ),
    );
  }
}

class MainScreenRegisterDonation extends StatelessWidget {
  final double screenWidth;
  final String mainScreenImagesPath;
  const MainScreenRegisterDonation({
    super.key,
    required this.screenWidth,
    required this.mainScreenImagesPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VoluteenMainScreenHeadingItem(
            title: LocaleKeys.home_donate_with_us.tr(),
            lineWidth: context.locale.languageCode == 'ar'
                ? screenWidth * 0.18
                : screenWidth * 0.28,
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: VolunteenColors.lightGrey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  child: Image.asset(
                    'assets/images/main_screen/donation.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: VolunteenFilledElevatedButton(
                  borderWidth: 1,
                  borderColor: VolunteenColors.blue,
                  backgroundColor: VolunteenColors.babyBlue,
                  text: LocaleKeys.home_submit_your_donation.tr(),
                  textColor: VolunteenColors.darkBlue,
                  imagePath: '$mainScreenImagesPath/submit_donation.png',
                  borderRadius: 5,
                  height: 40,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  onPressed: () {
                    context.router.push(SubmitDonationRoute());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MainScreenUsersDonations extends StatelessWidget {
  final double screenWidth;
  const MainScreenUsersDonations({
    super.key,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDonationHandler, AllDonationState>(
      builder: (context, state) {
        final List<Donation> donations =
            context.read<AllDonationHandler>().allDonations;
        final ImageLoaderHandler imageLoaderHandler = context.read();
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VoluteenMainScreenHeadingItem(
                title: LocaleKeys.home_donations.tr(),
                lineWidth: context.locale.languageCode == 'ar'
                    ? screenWidth * 0.33
                    : screenWidth * 0.20,
              ),
              const SizedBox(
                height: 10,
              ),
              if (donations.isNotEmpty)
                Container(
                  alignment: Alignment.center,
                  width: screenWidth,
                  height: 175,
                  child: ListView.builder(
                    itemCount: donations.length < 4 ? donations.length : 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.router.push(DetailedDonationRoute(
                              donation: donations[index]));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[600]!, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Stack(
                              children: [
                                ImageLoaderWidget(
                                  id: donations[index].id,
                                  function: () => imageLoaderHandler.getImage(
                                    'donation/${donations[index].id}',
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    color: Colors.black.withOpacity(
                                      0.6,
                                    ),
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        donations[index].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class MainScreenHelpingHands extends StatelessWidget {
  final double screenWidth;
  final String helpingHandsImagesPath;
  const MainScreenHelpingHands(
      {super.key,
      required this.screenWidth,
      required this.helpingHandsImagesPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VoluteenMainScreenHeadingItem(
            title: LocaleKeys.home_get_helping_hand.tr(),
            lineWidth: context.locale.languageCode == 'ar'
                ? screenWidth * 0.4
                : screenWidth * 0.35,
          ),
          const SizedBox(
            height: 10,
          ),
          VolunteenMainScreenHelpingHandsRow(
            helpRequestsImagesPath: helpingHandsImagesPath,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: VolunteenFilledElevatedButton(
              borderWidth: 3,
              borderColor: VolunteenColors.darkGreen,
              backgroundColor: VolunteenColors.lightGreen,
              text: LocaleKeys.home_join_helping_hands.tr(),
              onPressed: () {
                context.router.push(NewHelpingHandRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreenCountryDropDownMenu extends StatelessWidget {
  const MainScreenCountryDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: 'Egypt',
        items: [
          DropdownMenuItem(
            value: 'Egypt',
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: VolunteenColors.blue,
                ),
                SizedBox(width: 8),
                Text(LocaleKeys.countries_egypt.tr(),
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          // Handle the selection change
        },
        icon: const Icon(
          Icons.arrow_drop_down,
          color: VolunteenColors.blue,
        ),
      ),
    );
  }
}

class VolunteenMainScreenSearchBar extends StatelessWidget {
  const VolunteenMainScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: VolunteenColors.blue,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 20,
              color: VolunteenColors.orange,
            ),
            Expanded(
              child: Text(
                LocaleKeys.home_search.tr(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VolunteenHelpRequestHelpingHandsItem extends StatelessWidget {
  final String imagePath;
  final String title;
  const VolunteenHelpRequestHelpingHandsItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(imagePath),
        ),
        const SizedBox(
          height: 5,
        ),
        AutoSizeText(
          title,
          maxFontSize: 12,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class VolunteenMainScreenHelpRequestRow extends StatelessWidget {
  final String helpRequestsImagesPath;
  const VolunteenMainScreenHelpRequestRow(
      {super.key, required this.helpRequestsImagesPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                SubmitHelpRequestRoute(
                  helpCategory: HelpCategory.delivery,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/assistance.png',
              title: StringUtility.getHelpCategoryName(
                  HelpCategory.delivery, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                SubmitHelpRequestRoute(
                  helpCategory: HelpCategory.petCare,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/pets_care.png',
              title: StringUtility.getHelpCategoryName(
                  HelpCategory.petCare, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                SubmitHelpRequestRoute(
                  helpCategory: HelpCategory.childCare,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/child_care.png',
              title: StringUtility.getHelpCategoryName(
                  HelpCategory.childCare, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                SubmitHelpRequestRoute(
                  helpCategory: HelpCategory.elderlyHelp,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/elderly_care.png',
              title: StringUtility.getHelpCategoryName(
                  HelpCategory.elderlyHelp, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                SubmitHelpRequestRoute(
                  helpCategory: HelpCategory.other,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/other.png',
              title: StringUtility.getHelpCategoryName(
                  HelpCategory.other, context),
            ),
          ),
        ),
      ],
    );
  }
}

class VolunteenMainScreenHelpingHandsRow extends StatelessWidget {
  final String helpRequestsImagesPath;
  const VolunteenMainScreenHelpingHandsRow(
      {super.key, required this.helpRequestsImagesPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                HelpingHandsRoute(
                  helpingHandCategory: HelpingHandCategory.mentalHealth,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/mental_health.png',
              title: StringUtility.getHelpingHandCategoryName(
                  HelpingHandCategory.mentalHealth, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                HelpingHandsRoute(
                  helpingHandCategory: HelpingHandCategory.family,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/family.png',
              title: StringUtility.getHelpingHandCategoryName(
                  HelpingHandCategory.family, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                HelpingHandsRoute(
                  helpingHandCategory: HelpingHandCategory.health,
                ),
              );
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/health.png',
              title: StringUtility.getHelpingHandCategoryName(
                  HelpingHandCategory.health, context),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(HelpingHandsRoute(
                  helpingHandCategory: HelpingHandCategory.education));
            },
            child: VolunteenHelpRequestHelpingHandsItem(
              imagePath: '$helpRequestsImagesPath/education.png',
              title: StringUtility.getHelpingHandCategoryName(
                  HelpingHandCategory.education, context),
            ),
          ),
        ),
      ],
    );
  }
}

class VoluteenMainScreenHeadingItem extends StatelessWidget {
  final String title;
  final double lineWidth;
  const VoluteenMainScreenHeadingItem({
    super.key,
    required this.title,
    required this.lineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: lineWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 10,
            color: VolunteenColors.orange,
            thickness: 5,
          ),
        ],
      ),
    );
  }
}
