import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/donation.dart';
import 'package:volunteen/data/repositories/donations.dart';
import 'package:volunteen/data/repositories/user.dart';

part 'state.dart';

class SavedDonationsHandler extends Cubit<SavedDonationsState> {
  final UserRepository userRepository;
  final DonationRepository donationRepository;
  List<Donation> allDonations = [];
  SavedDonationsHandler({
    required this.userRepository,
    required this.donationRepository,
  }) : super(SavedDonationsStateInitial());

  Future<void> getDonations(
    final List<String> favDonations,
  ) async {
    emit(SavedDonationsStateGetDonationsLoading());
    try {
      allDonations = await donationRepository.getDonations();
      allDonations
          .removeWhere((donation) => !favDonations.contains(donation.id));
      emit(SavedDonationsStateGetDonationsSuccess());
    } on Exception catch (error) {
      emit(SavedDonationsStateGetDonationsFailure(error: error.toString()));
    }
  }

  Future<void> addFavDonation(
    final String userId,
    final String donationId,
  ) async {
    if (state is SavedDonationsStateAddFavDonationLoading) return;
    emit(SavedDonationsStateAddFavDonationLoading());
    try {
      await userRepository.addDonation(userId, donationId);
      emit(SavedDonationsStateAddFavDonationSuccess());
    } on Exception catch (error) {
      emit(SavedDonationsStateAddFavDonationFailure(error: error.toString()));
    }
  }

  Future<void> removeFavDonation(
    final String userId,
    final String donationId,
  ) async {
    if (state is SavedDonationsStateRemoveFavDonationLoading) return;
    emit(SavedDonationsStateRemoveFavDonationLoading());
    try {
      await userRepository.removeDonation(userId, donationId);
      emit(SavedDonationsStateRemoveFavDonationSuccess());
    } on Exception catch (error) {
      emit(
          SavedDonationsStateRemoveFavDonationFailure(error: error.toString()));
    }
  }
}
