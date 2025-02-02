part of 'handler.dart';

sealed class NewHelpingHandState extends Equatable {
  const NewHelpingHandState();

  @override
  List<Object> get props => [];
}

final class NewHelpingHandStateInitial extends NewHelpingHandState {}

final class NewHelpingHandStateLoading extends NewHelpingHandState {}

final class NewHelpingHandStateSuccess extends NewHelpingHandState {}

final class NewHelpingHandStateFailure extends NewHelpingHandState {
  final String error;

  const NewHelpingHandStateFailure({required this.error});
}
