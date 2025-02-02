import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/services_list/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/business_logic/routing/routes.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/help_request_card.dart';
import 'package:volunteen/utility/string_utility.dart';

@RoutePage()
class ServicesListScreen extends StatelessWidget {
  final HelpCategory helpCategory;
  const ServicesListScreen({
    super.key,
    required this.helpCategory,
  });

  @override
  Widget build(BuildContext context) {
    final SessionHandler sessionHandler = context.read<SessionHandler>();
    final String userId = sessionHandler.currentUser.id;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.router.replaceAll([ServicesRoute()]);
          },
        ),
        title: Text(
          StringUtility.getHelpCategoryName(
            helpCategory,
            context,
          ),
        ),
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
      ),
      body: BlocProvider(
        create: (context) => ServicesListHandler(
          helpRequestRepository: context.read(),
        )..getCategoryServices(
            helpCategory,
            userId,
          ),
        child: BlocBuilder<ServicesListHandler, ServicesListState>(
          builder: (context, state) {
            final List<HelpRequest> helpRequests =
                context.read<ServicesListHandler>().categoryHelpRequests;
            if (helpRequests.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: helpRequests.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: VolunteenHelpRequestCard(
                    helpRequest: helpRequests[index],
                    isEditAuth: false,
                    onDelete: () {},
                    onTap: () {
                      context.router.push(
                        ServiceDetailedRoute(
                          helpRequest: helpRequests[index],
                          userId: userId,
                        ),
                      );
                    },
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
