import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/feedback/handler.dart';
import 'package:volunteen/business_logic/handler/session/handler.dart';
import 'package:volunteen/data/models/feedback.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/button.dart';
import 'package:volunteen/presentation/widgets/input.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;

@RoutePage()
class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String userId = context.read<SessionHandler>().currentUser.id;
    final isRTL = Directionality.of(context) == ui.TextDirection.rtl;
    return BlocProvider(
      create: (context) => FeedbackHandler(
        feedbackRepository: context.read(),
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: VolunteenColors.white,
          backgroundColor: VolunteenColors.pink,
          title: Text(
            LocaleKeys.feedback_screen_app_bar_title.tr(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<FeedbackHandler, FeedbackState>(
          builder: (context, state) {
            final FeedbackHandler feedbackHandler = context.read();
            final double rating = feedbackHandler.rating;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.feedback_screen_rate_your_experience.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isRTL
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            feedbackHandler.updateRating(index + 1.0);
                          },
                          icon: Icon(
                            Icons.star,
                            color: index < rating ? Colors.amber : Colors.grey,
                            size: 30,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  VolunteenTextFormField(
                    labelText:
                        LocaleKeys.feedback_screen_give_your_opinion.tr(),
                    controller: _feedbackController,
                    maxLines: 5,
                    fontSize: 18,
                    textDirection:
                        isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                    inputDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: LocaleKeys.feedback_screen_write_here.tr(),
                      hintTextDirection:
                          isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: VolunteenFilledElevatedButton(
                      text: LocaleKeys.buttons_send.tr(),
                      onPressed: () {
                        feedbackHandler.submitRating(
                          VolunteenFeedback(
                            userId: userId,
                            rating: rating,
                            opinion: _feedbackController.text,
                          ),
                        );
                        _feedbackController.clear();
                        feedbackHandler.updateRating(0.0);
                      },
                    ),
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
