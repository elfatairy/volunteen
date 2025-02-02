import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/data/repositories/donations.dart';
import 'package:volunteen/data/repositories/storage.dart';

part 'state.dart';

class UserDonationHandler extends Cubit<UserDonationState> {
  final DonationRepository donationRepository;
  final StorageRepository storageRepository;
  StreamSubscription<List<Donation>>? _subscription;
  List<Donation> userDonations = [];
  UserDonationHandler({
    required this.donationRepository,
    required this.storageRepository,
  }) : super(UserDonationStateInitial());

  void listenToUserDonations(final String userId) {
    _subscription?.cancel();
    emit(UserDonationStateGetDonationsLoading());

    _subscription =
        donationRepository.getUserDonations(userId).listen((donations) {
      userDonations = donations;
      emit(UserDonationStateGetDonationsSuccess(dateTime: DateTime.now()));
    }, onError: (error) {
      emit(UserDonationStateGetDonationsFailure(error: error.toString()));
    });
  }

  Future<void> deleteDonation(final String donationId) async {
    if (state is UserDonationStateDonationDeleteLoading) return;
    emit(UserDonationStateDonationDeleteLoading());

    try {
      await donationRepository.deleteDonation(donationId);
      await storageRepository.deleteFolder('donation/$donationId');
      emit(UserDonationStateDonationDeleteSuccess());
    } on Exception catch (error) {
      emit(UserDonationStateDonationDeleteFailure(error: error.toString()));
    }
  }
}
