part of 'handler.dart';

sealed class AccountScreenState extends Equatable {
  const AccountScreenState();

  @override
  List<Object> get props => [];
}

final class AccountScreenStateInitial extends AccountScreenState {}

final class AccountScreenStateLogOutLoading extends AccountScreenState {}

final class AccountScreenStateLogOutSuccess extends AccountScreenState {}

final class AccountScreenStateLogOutFailure extends AccountScreenState {
  final String error;

  const AccountScreenStateLogOutFailure({required this.error});
}

final class AccountScreenStateGetShareAppLoading extends AccountScreenState {}

final class AccountScreenStateGetShareAppSuccess extends AccountScreenState {}

final class AccountScreenStateGetShareAppFailure extends AccountScreenState {
  final String error;

  const AccountScreenStateGetShareAppFailure({required this.error});
}

final class AccountScreenStateEmergencyLoading extends AccountScreenState {}

final class AccountScreenStateEmergencySuccess extends AccountScreenState {}

final class AccountScreenStateEmergencyFailure extends AccountScreenState {
  final String error;

  const AccountScreenStateEmergencyFailure({required this.error});
}
