import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:volunteen/data/enums/user_roles.dart';
import 'package:volunteen/data/models/user.dart';
import 'package:volunteen/data/repositories/user.dart';
import 'package:volunteen/data/repositories/volunteer.dart';

class AuthenticationRepository {
  auth.FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  UserRepository userRepository;
  VolunteerRepository volunteersRepository;

  AuthenticationRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.userRepository,
    required this.volunteersRepository,
  }) {
    _init();
  }

  VolunteenUser currentUser = VolunteenUser.emptyUser;
  late StreamController<VolunteenUser> _userController;
  Stream<VolunteenUser> get user => _userController.stream;

  Future<void> _init() async {
    _userController = StreamController<VolunteenUser>.broadcast();

    firebaseAuth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        final userDocRef = await firebaseFirestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        final VolunteenUser user =
            VolunteenUser.fromJson(userDocRef.id, userDocRef.data()!);
        currentUser = user;
        _userController.add(user);
      } else {
        currentUser = VolunteenUser.emptyUser;
        _userController.add(currentUser);
      }

      if (firebaseAuth.currentUser != null) {
        firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            final user = VolunteenUser.fromJson(snapshot.id, snapshot.data()!);
            currentUser = user;
            _userController.add(user);
          } else {
            currentUser = VolunteenUser.emptyUser;
            _userController.add(currentUser);
          }
        });
      }
    });
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String? whatsAppNumber,
  }) async {
    auth.UserCredential createdUser =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userRepository.createUserDocument(
      currentUser.copyWith(
        id: createdUser.user!.uid,
        name: name,
        email: email,
        savedDonations: [],
        userRoles: [
          UserRoles.normal,
        ],
        subsDonation: false,
        subsHelpRequest: false,
      ),
    );

    if (whatsAppNumber != null) {
      await volunteersRepository.createUserDocument(
        createdUser.user!.uid,
        name,
        email,
        whatsAppNumber,
      );
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    await Future.wait([
      firebaseAuth.signOut(),
    ]);
  }

  void dispose() {
    _userController.close();
  }
}
