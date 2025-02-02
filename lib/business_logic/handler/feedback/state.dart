part of 'handler.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackStateInitial extends FeedbackState {}

final class FeedbackStateChangeRating extends FeedbackState {
  final double rating;

  const FeedbackStateChangeRating({required this.rating});

  @override
  List<Object> get props => [rating];
}

final class FeedbackStateSubmitLoading extends FeedbackState {}

final class FeedbackStateSubmitSuccess extends FeedbackState {}

final class FeedbackStateSubmitFailure extends FeedbackState {
  final String error;

  const FeedbackStateSubmitFailure({required this.error});
}
