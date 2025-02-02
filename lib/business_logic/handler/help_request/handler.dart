import 'package:bloc/bloc.dart';
import 'package:volunteen/business_logic/handler/send_notification/handler.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/data/repositories/help_request.dart';

part 'state.dart';

class SubmitHelpRequestHandler extends Cubit<HelpRequestState> {
  final HelpRequestRepository helpRequestRepository;
  final SendNotificationHandler sendNotificationHandler;
  List<HelpRequest> userHelpRequests = [];
  SubmitHelpRequestHandler({
    required this.helpRequestRepository,
    required this.sendNotificationHandler,
  }) : super(HelpRequestStateInitial());

  Future<void> createHelpRequest(final HelpRequest helpRequest) async {
    emit(HelpRequestStateSubmitLoading());

    try {
      await helpRequestRepository.createHelpRequest(helpRequest);
      emit(HelpRequestStateSubmitSuccess());
      await sendNotificationHandler.sendCustomNotification(
        "هناك فرصة تطوع جديدة",
        helpRequest.title,
        "help_request",
      );
    } on Exception catch (error) {
      emit(HelpRequestStateSubmitFailure(error: error.toString()));
    }
  }
}
