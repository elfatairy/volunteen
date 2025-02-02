part of 'handler.dart';

sealed class HelpRequestLoadState extends Equatable {
  const HelpRequestLoadState();

  @override
  List<Object> get props => [];
}

final class HelpRequestLoadStateInitial extends HelpRequestLoadState {}

final class HelpRequestLoadStateUserHelpRequestLoading
    extends HelpRequestLoadState {}

final class HelpRequestLoadStateUserHelpRequestSuccess
    extends HelpRequestLoadState {
  final DateTime dateTime;

  const HelpRequestLoadStateUserHelpRequestSuccess({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

final class HelpRequestLoadStateUserHelpRequestFailure
    extends HelpRequestLoadState {
  final String error;

  const HelpRequestLoadStateUserHelpRequestFailure({required this.error});
}

final class HelpRequestLoadStateDeleteRequestLoading
    extends HelpRequestLoadState {}

final class HelpRequestLoadStateDeleteRequestSuccess
    extends HelpRequestLoadState {}

final class HelpRequestLoadStateDeleteRequestFailure
    extends HelpRequestLoadState {
  final String error;

  const HelpRequestLoadStateDeleteRequestFailure({required this.error});
}
