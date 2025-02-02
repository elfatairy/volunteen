import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/app/global_providers/handler.dart';
import 'package:volunteen/app/global_providers/repository.dart';
import 'package:volunteen/app/volunteen_app.dart';
import 'package:volunteen/firebase_options.dart';
import 'package:volunteen/translation/codegen_loader.g.dart';
import 'package:volunteen/utility/app_bloc_observer.dart';
import 'package:volunteen/utility/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      child: VolunteenGlobalRepositories(
        child: const VolunteenGlobalHandlers(
          child: VolunteenApp(),
        ),
      ),
    );
  }
}
