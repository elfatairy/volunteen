import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/feedback.dart';
import 'package:volunteen/data/repositories/feedback.dart';

part 'state.dart';

class FeedbackHandler extends Cubit<FeedbackState> {
  double rating = 0.0;
  final FeedbackRepository feedbackRepository;
  FeedbackHandler({required this.feedbackRepository})
      : super(FeedbackStateInitial());

  void updateRating(final double rating) {
    this.rating = rating;
    emit(FeedbackStateChangeRating(rating: rating));
  }

  Future<void> submitRating(final VolunteenFeedback volunteenFeedback) async {
    if (state is FeedbackStateSubmitLoading) return;
    emit(FeedbackStateSubmitLoading());
    try {
      await feedbackRepository.addFeedback(volunteenFeedback);
      emit(FeedbackStateSubmitSuccess());
    } on Exception catch (error) {
      emit(FeedbackStateSubmitFailure(error: error.toString()));
    }
  }
}
