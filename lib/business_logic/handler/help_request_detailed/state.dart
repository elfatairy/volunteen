part of 'handler.dart';

sealed class HelpRequestDetailedState extends Equatable {
  const HelpRequestDetailedState();

  @override
  List<Object> get props => [];
}

final class HelpRequestDetailedStateInitial extends HelpRequestDetailedState {}

final class HelpRequestDetailedStateDeleteLoading
    extends HelpRequestDetailedState {}

final class HelpRequestDetailedStateDeleteSuccess
    extends HelpRequestDetailedState {}

final class HelpRequestDetailedStateDeleteFailure
    extends HelpRequestDetailedState {
  final String error;

  const HelpRequestDetailedStateDeleteFailure({required this.error});
}

final class HelpRequestDetailedStateUserLoading
    extends HelpRequestDetailedState {}

final class HelpRequestDetailedStateUserSuccess
    extends HelpRequestDetailedState {}

final class HelpRequestDetailedStateUserFailure
    extends HelpRequestDetailedState {
  final String error;

  const HelpRequestDetailedStateUserFailure({required this.error});
}
