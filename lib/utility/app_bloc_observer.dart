// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(
        '=============================================================================================================');
    print(bloc.toString() + ' has event: ' + event.toString());
    print(
        '=============================================================================================================');
    super.onEvent(bloc, event);
  }

  @override
  void onCreate(BlocBase bloc) {
    print('-----------------------------------------------------------------------> create: ' +
        bloc.toString() +
        ' <-----------------------------------------------------------------------');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(
        '=============================================================================================================');
    print(bloc.toString() + ' has change: ' + change.toString());
    print(
        '=============================================================================================================');
    super.onChange(bloc, change);
  }
}
