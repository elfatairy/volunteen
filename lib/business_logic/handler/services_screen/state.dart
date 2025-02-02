part of 'handler.dart';

sealed class ServicesScreenState extends Equatable {
  const ServicesScreenState();

  @override
  List<Object> get props => [];
}

final class ServicesScreenStateInitial extends ServicesScreenState {}

final class ServicesScreenStateToggleSubsHelpRequestLoading
    extends ServicesScreenState {}

final class ServicesScreenStateToggleSubsHelpRequestSuccess
    extends ServicesScreenState {}

final class ServicesScreenStateToggleSubsHelpRequestFailure
    extends ServicesScreenState {
  final String error;

  const ServicesScreenStateToggleSubsHelpRequestFailure({required this.error});
}
