import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/user.dart';
import 'package:volunteen/data/repositories/authentication.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'state.dart';

class SessionHandler extends Cubit<SessionState> {
  final AuthenticationRepository authRepository;

  VolunteenUser currentUser = VolunteenUser.emptyUser;
  StreamSubscription<VolunteenUser>? _userSubscription;
  late StreamController<VolunteenUser> _userController;
  Stream<VolunteenUser> get user => _userController.stream;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  SessionHandler({required this.authRepository})
      : super(SessionStateInitial()) {
    _userController = StreamController<VolunteenUser>.broadcast();
    _userSubscription = authRepository.user.listen(
      (retrievedUser) {
        currentUser = retrievedUser;
        _userController.add(retrievedUser);
        retrievedUser != VolunteenUser.emptyUser
            ? emit(
                SessionStateAuthenticated(
                  dateTime: DateTime.now(),
                ),
              )
            : emit(SessionStateUnauthenticated(dateTime: DateTime.now()));
      },
    );
  }

  void signOut() {
    authRepository.logOut().then((_) {
      emit(SessionStateUnauthenticated(dateTime: DateTime.now()));
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
