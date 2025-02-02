part of 'handler.dart';

@immutable
sealed class SignupState {
  const SignupState();
}

class SignupStateInitial extends SignupState {}

class SignupStateLoading extends SignupState {}

class SignupStateSuccess extends SignupState {}

class SignupStateFailure extends SignupState {
  final String error;

  const SignupStateFailure({required this.error});
}

class SignupStateVolunteerLoading extends SignupState {}

class SignupStateVolunteerSuccess extends SignupState {}

class SignupStateVolunteerFailure extends SignupState {
  final String error;

  const SignupStateVolunteerFailure({required this.error});
}
