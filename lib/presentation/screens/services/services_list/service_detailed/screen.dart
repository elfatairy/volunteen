// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/service_detailed/handler.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/help_request_detailed_column.dart';

@RoutePage()
class ServiceDetailedScreen extends StatelessWidget {
  final HelpRequest helpRequest;
  final String userId;
  const ServiceDetailedScreen({
    super.key,
    required this.helpRequest,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: VolunteenColors.white,
        backgroundColor: VolunteenColors.pink,
        title: Text(
          helpRequest.title,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            ServiceDetailedHandler(helpRequestRepository: context.read()),
        child: BlocBuilder<ServiceDetailedHandler, ServiceDetailedState>(
          builder: (context, state) {
            final ServiceDetailedHandler serviceDetailedHandler =
                context.read();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HelpRequestDetailsColumn(
                    helpRequest: helpRequest,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (helpRequest.helpingUserId != userId)
                    VolunteenFilledElevatedButton(
                      text: 'التطوع لهذة الخدمة',
                      onPressed: () {
                        serviceDetailedHandler
                            .addHelpingUserId(
                              helpRequest.id,
                              userId,
                            )
                            .then(
                              (_) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'لقد تطوعت لهذه الخدمة!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black,
                                    duration: Duration(seconds: 2),
                                  ),
                                )
                              },
                            );
                      },
                    ),
                  if (helpRequest.helpingUserId == userId)
                    VolunteenFilledElevatedButton(
                      text: 'إلغاء التطوع',
                      onPressed: () {
                        serviceDetailedHandler
                            .removeHelpingUserId(
                              helpRequest.id,
                              userId,
                            )
                            .then(
                              (_) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'تم إلغاء التطوع!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black,
                                    duration: Duration(seconds: 2),
                                  ),
                                )
                              },
                            );
                      },
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
