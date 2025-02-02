import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/helping_hand.dart';
import 'package:volunteen/data/repositories/helping_hand.dart';
import 'package:volunteen/data/repositories/storage.dart';

part 'state.dart';

class HelpingHandHandler extends Cubit<HelpingHandState> {
  final HelpingHandRepository helpingHandRepository;
  final StorageRepository storageRepository;
  List<HelpingHand> helpingHands = [];
  HelpingHandHandler({
    required this.helpingHandRepository,
    required this.storageRepository,
  }) : super(HelpingHandStateInitial());

  Future<void> getHelpingHandsForCategory(
    final HelpingHandCategory helpingHandCategory,
  ) async {
    if (state is HelpingHandStateLoadLoading) return;
    emit(HelpingHandStateLoadLoading());
    try {
      helpingHands = await helpingHandRepository
          .getHelpingHandsForCategory(helpingHandCategory);
      emit(HelpingHandStateLoadSuccess());
    } on Exception catch (error) {
      emit(HelpingHandStateLoadFailure(error: error.toString()));
    }
  }

  Future<String> getHelpingHandImage(
    final String helpingHandId,
    final HelpingHandCategory helpingHandCategory,
  ) async {
    emit(HelpingHandStateLoadImageLoading());
    final String imagePath =
        'helping_hand/${helpingHandCategory.toMap()}/$helpingHandId';
    try {
      Reference? imageReference = await storageRepository.getImage(imagePath);
      if (imageReference != null) {
        final String imageURL = await imageReference.getDownloadURL();
        emit(HelpingHandStateLoadImageSuccess());
        return imageURL;
      }
    } on Exception catch (error) {
      emit(HelpingHandStateLoadImageFailure(error: error.toString()));
    }
    emit(const HelpingHandStateLoadFailure(error: 'Failed to load image'));
    return '';
  }
}
