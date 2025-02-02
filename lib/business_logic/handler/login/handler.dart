import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/data/repositories/authentication.dart';

part 'state.dart';

class LoginHandler extends Cubit<LoginState> {
  final AuthenticationRepository authRepository;

  LoginHandler({required this.authRepository}) : super(LoginStateInitial());

  Future<void> logInWithCredentials(
    final String emailAddres,
    final String password,
  ) async {
    if (state is LoginStateLoading) return;
    emit(LoginStateLoading());
    try {
      await authRepository.logInWithEmailAndPassword(
        email: emailAddres,
        password: password,
      );
      emit(LoginStateSuccess());
    } catch (error) {
      emit(LoginStateFailure(error: error.toString()));
    }
  }
}
