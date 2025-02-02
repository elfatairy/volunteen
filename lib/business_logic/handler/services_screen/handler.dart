import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volunteen/data/repositories/user.dart';

part 'state.dart';

class ServicesScreenHandler extends Cubit<ServicesScreenState> {
  final UserRepository userRepository;
  final FirebaseMessaging firebaseMessaging;
  ServicesScreenHandler({
    required this.userRepository,
    required this.firebaseMessaging,
  }) : super(ServicesScreenStateInitial());

  Future<void> toggleSubsDonation(
      final String userId, final bool subsHelpRequest) async {
    if (state is ServicesScreenStateToggleSubsHelpRequestLoading) return;
    emit(ServicesScreenStateToggleSubsHelpRequestLoading());
    if (subsHelpRequest) {
      await firebaseMessaging.requestPermission();
    }
    try {
      await userRepository.updateSubsHelpRequest(userId, subsHelpRequest);
      if (subsHelpRequest == true) {
        await firebaseMessaging.subscribeToTopic('help_request');
      } else {
        await firebaseMessaging.unsubscribeFromTopic('help_request');
      }
      emit(ServicesScreenStateToggleSubsHelpRequestSuccess());
    } on Exception catch (error) {
      emit(ServicesScreenStateToggleSubsHelpRequestFailure(
          error: error.toString()));
    }
  }
}
