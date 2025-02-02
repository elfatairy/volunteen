import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteen/data/repositories/announcement.dart';
import 'package:volunteen/data/repositories/authentication.dart';
import 'package:volunteen/data/repositories/contact_us.dart';
import 'package:volunteen/data/repositories/donations.dart';
import 'package:volunteen/data/repositories/emergency.dart';
import 'package:volunteen/data/repositories/feedback.dart';
import 'package:volunteen/data/repositories/help_request.dart';
import 'package:volunteen/data/repositories/helping_hand.dart';
import 'package:volunteen/data/repositories/new_helping_hand.dart';
import 'package:volunteen/data/repositories/share_app.dart';
import 'package:volunteen/data/repositories/storage.dart';
import 'package:volunteen/data/repositories/supporter.dart';
import 'package:volunteen/data/repositories/user.dart';
import 'package:volunteen/data/repositories/volunteer.dart';

class VolunteenGlobalRepositories extends StatelessWidget {
  final Widget child;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  VolunteenGlobalRepositories({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => VolunteerRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(
            firebaseStorage: firebaseStorage,
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationRepository(
            firebaseAuth: firebaseAuth,
            firebaseFirestore: firebaseFirestore,
            userRepository: context.read(),
            volunteersRepository: context.read(),
          ),
        ),
        RepositoryProvider(
          create: (context) => HelpRequestRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => DonationRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => HelpingHandRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => AnnouncementRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => FeedbackRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => ShareAppRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => ContactUsRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => SupporterRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => EmergencyRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider(
          create: (context) => NewHelpingHandRepository(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
      ],
      child: child,
    );
  }
}
