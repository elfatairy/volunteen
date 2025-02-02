import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/new_helping_hand.dart';
import 'package:volunteen/data/repositories/new_helping_hand.dart';

part 'state.dart';

class NewHelpingHandHandler extends Cubit<NewHelpingHandState> {
  final NewHelpingHandRepository newHelpingHandsRepository;
  NewHelpingHandHandler({required this.newHelpingHandsRepository})
      : super(NewHelpingHandStateInitial());

  Future<void> createNewHelpingHand(final NewHelpingHand newHelpingHand) async {
    if (state is NewHelpingHandStateLoading) return;
    try {
      await newHelpingHandsRepository.createNewHelpingHand(newHelpingHand);
      emit(NewHelpingHandStateSuccess());
    } on Exception catch (error) {
      emit(NewHelpingHandStateFailure(error: error.toString()));
    }
  }
}
