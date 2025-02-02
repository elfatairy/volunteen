part of 'handler.dart';

sealed class HelpRequestState {
  const HelpRequestState();
}

final class HelpRequestStateInitial extends HelpRequestState {}

final class HelpRequestStateSubmitLoading extends HelpRequestState {}

final class HelpRequestStateSubmitSuccess extends HelpRequestState {}

final class HelpRequestStateSubmitFailure extends HelpRequestState {
  final String error;

  const HelpRequestStateSubmitFailure({required this.error});
}
