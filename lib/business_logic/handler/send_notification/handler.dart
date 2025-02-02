import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_functions/cloud_functions.dart';

part 'state.dart';

class SendNotificationHandler extends Cubit<SendNotificationState> {
  SendNotificationHandler() : super(SendNotificationStateInitial());

  Future<void> sendCustomNotification(
    final String title,
    final String body,
    final String topic,
  ) async {
    emit(SendNotificationStateLoading());
    try {
      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('fireNotification');

      final Map<String, dynamic> data = {
        'title': title,
        'body': body,
        'topic': topic,
      };

      callable.call(data).then((value) {
        emit(SendNotificationStateSuccess());
      });
    } catch (error) {
      emit(SendNotificationStateFailure(error: error.toString()));
    }
  }
}
