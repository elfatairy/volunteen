import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/business_logic/handler/send_notification/handler.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/data/repositories/donations.dart';
import 'package:volunteen/data/repositories/storage.dart';

part 'state.dart';

class CreateDonationHandler extends Cubit<CreateDonationState> {
  final DonationRepository donationRepository;
  final SendNotificationHandler sendNotificationHandler;
  final StorageRepository storageRepository;
  CreateDonationHandler({
    required this.donationRepository,
    required this.sendNotificationHandler,
    required this.storageRepository,
  }) : super(CreateDonationHandlerStateInitial());

  Future<void> createDonation(
      final Donation donation, final File? image) async {
    if (state is CreateDonationHandlerStateLoading) return;

    emit(CreateDonationHandlerStateLoading());

    try {
      final String donationId =
          await donationRepository.createDonation(donation);

      if (image != null) {
        final String uploadFolder = "donation/$donationId";
        final String imageName = image.path.split('/').last;
        final String uploadReference = "$uploadFolder/$imageName";
        await storageRepository.uploadImage(image, uploadReference);
      }

      emit(CreateDonationHandlerStateSuccess());
      await sendNotificationHandler.sendCustomNotification(
        "هناك تبرع جديد",
        donation.title,
        "donation",
      );
    } on Exception catch (error) {
      emit(CreateDonationHandlerStateFailure(error: error.toString()));
    }
  }

  Future<void> uploadDonationImage(
    final String donationId,
    final File file,
  ) async {
    emit(CreateDonationHandlerStateLoading());
    try {
      final String uploadFolder = "donation/$donationId";
      final String imageName = file.path.split('/').last;
      final String uploadReference = "$uploadFolder/$imageName";
      await storageRepository.uploadImage(file, uploadReference);
      emit(CreateDonationHandlerStateSuccess());
    } on Exception catch (error) {
      emit(CreateDonationHandlerStateFailure(error: error.toString()));
    }
  }
}
