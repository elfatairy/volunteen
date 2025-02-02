part of 'handler.dart';

sealed class HelpingHandState extends Equatable {
  const HelpingHandState();

  @override
  List<Object> get props => [];
}

final class HelpingHandStateInitial extends HelpingHandState {}

final class HelpingHandStateLoadLoading extends HelpingHandState {}

final class HelpingHandStateLoadSuccess extends HelpingHandState {}

final class HelpingHandStateLoadFailure extends HelpingHandState {
  final String error;

  const HelpingHandStateLoadFailure({required this.error});
}

final class HelpingHandStateLoadImageLoading extends HelpingHandState {}

final class HelpingHandStateLoadImageSuccess extends HelpingHandState {}

final class HelpingHandStateLoadImageFailure extends HelpingHandState {
  final String error;

  const HelpingHandStateLoadImageFailure({required this.error});
}
