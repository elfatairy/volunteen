import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/data/repositories/donations.dart';
import 'package:volunteen/data/repositories/user.dart';

part 'state.dart';

class AllDonationHandler extends Cubit<AllDonationState> {
  final DonationRepository donationRepository;
  final UserRepository userRepository;
  final FirebaseMessaging firebaseMessaging;
  StreamSubscription<List<Donation>>? _subscription;
  List<Donation> allDonations = [];
  AllDonationHandler({
    required this.donationRepository,
    required this.userRepository,
    required this.firebaseMessaging,
  }) : super(AllDonationStateInitial());

  void listenToAllDonations(final String userId) {
    _subscription?.cancel();
    emit(AllDonationStateGetLoading());

    _subscription =
        donationRepository.getAllDonations(userId).listen((donations) {
      allDonations = donations;
      emit(AllDonationStateGetSuccess(dateTime: DateTime.now()));
    }, onError: (error) {
      emit(AllDonationStateGetFailure(error: error.toString()));
    });
  }

  Future<void> addFavDonation(
    final String userId,
    final String donationId,
  ) async {
    if (state is AllDonationStateAddFavDonationLoading) return;
    emit(AllDonationStateAddFavDonationLoading());
    try {
      await userRepository.addDonation(userId, donationId);
      emit(AllDonationStateAddFavDonationSuccess());
    } on Exception catch (error) {
      emit(AllDonationStateAddFavDonationFailure(error: error.toString()));
    }
  }

  Future<void> removeFavDonation(
    final String userId,
    final String donationId,
  ) async {
    if (state is AllDonationStateRemoveFavDonationLoading) return;
    emit(AllDonationStateRemoveFavDonationLoading());
    try {
      await userRepository.removeDonation(userId, donationId);
      emit(AllDonationStateRemoveFavDonationSuccess());
    } on Exception catch (error) {
      emit(AllDonationStateRemoveFavDonationFailure(error: error.toString()));
    }
  }

  Future<void> subscribeDonation(
    final String userId,
  ) async {
    if (state is AllDonationStateToggleSubsDonationLoading) return;
    emit(AllDonationStateToggleSubsDonationLoading());
    await firebaseMessaging.requestPermission().then((value) async {
      try {
        await userRepository.updateSubsDonation(userId, true);
        firebaseMessaging.subscribeToTopic('donation');

        emit(AllDonationStateToggleSubsDonationSuccess());
      } on Exception catch (error) {
        emit(
            AllDonationStateToggleSubsDonationFailure(error: error.toString()));
      }
    });
  }

  Future<void> unsubscribeDonation(
    final String userId,
  ) async {
    if (state is AllDonationStateToggleSubsDonationLoading) return;
    emit(AllDonationStateToggleSubsDonationLoading());
    try {
      await userRepository.updateSubsDonation(userId, false);
      await firebaseMessaging.unsubscribeFromTopic('donation');
      emit(AllDonationStateToggleSubsDonationSuccess());
    } on Exception catch (error) {
      emit(AllDonationStateToggleSubsDonationFailure(error: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
