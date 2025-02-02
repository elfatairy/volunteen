part of 'handler.dart';

sealed class UserDonationState extends Equatable {
  const UserDonationState();

  @override
  List<Object> get props => [];
}

final class UserDonationStateInitial extends UserDonationState {}

final class UserDonationStateGetDonationsLoading extends UserDonationState {}

final class UserDonationStateGetDonationsSuccess extends UserDonationState {
  final DateTime dateTime;

  const UserDonationStateGetDonationsSuccess({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

final class UserDonationStateGetDonationsFailure extends UserDonationState {
  final String error;

  const UserDonationStateGetDonationsFailure({required this.error});
}

final class UserDonationStateDonationDeleteLoading extends UserDonationState {}

final class UserDonationStateDonationDeleteSuccess extends UserDonationState {}

final class UserDonationStateDonationDeleteFailure extends UserDonationState {
  final String error;

  const UserDonationStateDonationDeleteFailure({required this.error});
}
