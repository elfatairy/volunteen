// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/business_logic/handler/image_loader/handler.dart';
import 'package:volunteen/business_logic/handler/supporter/handler.dart';
import 'package:volunteen/data/models/supporter.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/presentation/widgets/image_loader.dart';
import 'package:volunteen/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class SupportesScreen extends StatelessWidget {
  const SupportesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupporterHandler(
        supporterRepository: context.read(),
        storageRepository: context.read(),
      )..getAllSupporters(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: VolunteenColors.white,
          backgroundColor: VolunteenColors.pink,
          title: Text(LocaleKeys.account_screen_supportes.tr()),
        ),
        body: BlocBuilder<SupporterHandler, SupporterState>(
          builder: (context, state) {
            final SupporterHandler supporterHandler =
                context.read<SupporterHandler>();
            final ImageLoaderHandler imageLoaderHandler = context.read();
            final List<Supporter> supporters = supporterHandler.supporters;
            if (supporters.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                itemCount: supporters.length,
                itemBuilder: (context, index) {
                  final Supporter supporter = supporters[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageLoaderWidget(
                            id: supporter.id,
                            function: () => imageLoaderHandler
                                .getImage('supporter/${supporter.id}'),
                            width: 130,
                            height: 130,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            context.locale.languageCode == 'ar'
                                ? supporter.nameAr
                                : supporter.nameEn,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                    height: 3,
                  );
                });
          },
        ),
      ),
    );
  }
}
