part of 'handler.dart';

sealed class SavedDonationsState extends Equatable {
  const SavedDonationsState();

  @override
  List<Object> get props => [];
}

final class SavedDonationsStateInitial extends SavedDonationsState {}

final class SavedDonationsStateGetDonationsLoading
    extends SavedDonationsState {}

final class SavedDonationsStateGetDonationsSuccess
    extends SavedDonationsState {}

final class SavedDonationsStateGetDonationsFailure extends SavedDonationsState {
  final String error;

  const SavedDonationsStateGetDonationsFailure({required this.error});
}

final class SavedDonationsStateAddFavDonationLoading
    extends SavedDonationsState {}

final class SavedDonationsStateAddFavDonationSuccess
    extends SavedDonationsState {}

final class SavedDonationsStateAddFavDonationFailure
    extends SavedDonationsState {
  final String error;

  const SavedDonationsStateAddFavDonationFailure({required this.error});
}

final class SavedDonationsStateRemoveFavDonationLoading
    extends SavedDonationsState {}

final class SavedDonationsStateRemoveFavDonationSuccess
    extends SavedDonationsState {}

final class SavedDonationsStateRemoveFavDonationFailure
    extends SavedDonationsState {
  final String error;

  const SavedDonationsStateRemoveFavDonationFailure({required this.error});
}
