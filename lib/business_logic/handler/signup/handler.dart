import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:volunteen/data/repositories/authentication.dart';

part 'state.dart';

class SignupHandler extends Cubit<SignupState> {
  final AuthenticationRepository authRepository;

  SignupHandler({required this.authRepository}) : super(SignupStateInitial());

  Future<void> signupNormalUser(
    String name,
    String email,
    String password,
  ) async {
    if (state is SignupStateLoading) return;
    emit(SignupStateLoading());
    try {
      await authRepository.signup(
        name: name,
        email: email,
        password: password,
      );
      emit(SignupStateSuccess());
    } catch (error) {
      emit(SignupStateFailure(error: error.toString()));
    }
  }

  Future<void> signupVolunteer(
    final String name,
    final String email,
    final String password,
    final String whatsAppNumber,
  ) async {
    if (state is SignupStateVolunteerLoading) return;
    emit(SignupStateVolunteerLoading());
    try {
      await authRepository.signup(
        name: name,
        email: email,
        password: password,
        whatsAppNumber: whatsAppNumber,
      );
      emit(SignupStateVolunteerSuccess());
    } catch (error) {
      emit(SignupStateVolunteerFailure(error: error.toString()));
    }
  }
}
