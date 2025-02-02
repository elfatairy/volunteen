import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/share_app.dart';
import 'package:volunteen/data/repositories/authentication.dart';
import 'package:volunteen/data/repositories/emergency.dart';
import 'package:volunteen/data/repositories/share_app.dart';

part 'state.dart';

class AccountScreenHandler extends Cubit<AccountScreenState> {
  final AuthenticationRepository authenticationRepository;
  final ShareAppRepository shareAppRepository;
  final EmergencyRepository emergencyRepository;
  ShareApp? shareApp;
  String? emergencyNumber;
  AccountScreenHandler({
    required this.authenticationRepository,
    required this.shareAppRepository,
    required this.emergencyRepository,
  }) : super(AccountScreenStateInitial());

  Future<void> getShareAppData() async {
    emit(AccountScreenStateGetShareAppLoading());
    try {
      shareApp = await shareAppRepository.getAppLink();
      emit(AccountScreenStateGetShareAppSuccess());
    } on Exception catch (error) {
      emit(AccountScreenStateGetShareAppFailure(error: error.toString()));
    }
  }

  Future<void> getEmergencyNumber() async {
    emit(AccountScreenStateEmergencyLoading());
    try {
      emergencyNumber = await emergencyRepository.getEmergencyNumber();
      emit(AccountScreenStateEmergencySuccess());
    } on Exception catch (error) {
      emit(AccountScreenStateEmergencyFailure(error: error.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AccountScreenStateLogOutLoading());
    try {
      await authenticationRepository.logOut();
      emit(AccountScreenStateLogOutSuccess());
    } catch (error) {
      emit(AccountScreenStateLogOutFailure(error: error.toString()));
    }
  }
}
