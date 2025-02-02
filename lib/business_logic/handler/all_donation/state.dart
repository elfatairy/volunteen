part of 'handler.dart';

sealed class AllDonationState extends Equatable {
  const AllDonationState();

  @override
  List<Object> get props => [];
}

final class AllDonationStateInitial extends AllDonationState {}

final class AllDonationStateGetLoading extends AllDonationState {}

final class AllDonationStateGetSuccess extends AllDonationState {
  final DateTime dateTime;

  const AllDonationStateGetSuccess({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

final class AllDonationStateGetFailure extends AllDonationState {
  final String error;

  const AllDonationStateGetFailure({required this.error});
}

final class AllDonationStateAddFavDonationLoading extends AllDonationState {}

final class AllDonationStateAddFavDonationSuccess extends AllDonationState {}

final class AllDonationStateAddFavDonationFailure extends AllDonationState {
  final String error;

  const AllDonationStateAddFavDonationFailure({required this.error});
}

final class AllDonationStateRemoveFavDonationLoading extends AllDonationState {}

final class AllDonationStateRemoveFavDonationSuccess extends AllDonationState {}

final class AllDonationStateRemoveFavDonationFailure extends AllDonationState {
  final String error;

  const AllDonationStateRemoveFavDonationFailure({required this.error});
}

final class AllDonationStateToggleSubsDonationLoading
    extends AllDonationState {}

final class AllDonationStateToggleSubsDonationSuccess
    extends AllDonationState {}

final class AllDonationStateToggleSubsDonationFailure extends AllDonationState {
  final String error;

  const AllDonationStateToggleSubsDonationFailure({required this.error});
}
