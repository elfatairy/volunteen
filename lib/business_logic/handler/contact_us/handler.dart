import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/contact_us.dart';
import 'package:volunteen/data/repositories/contact_us.dart';

part 'state.dart';

class ContactUsHandler extends Cubit<ContactUsState> {
  final ContactUsRepository contactUsRepository;
  ContactUs? contactUs;
  ContactUsHandler({
    required this.contactUsRepository,
  }) : super(ContactUsStateInitial());

  Future<void> getContactUs() async {
    emit(ContactUsStateLoading());
    try {
      contactUs = await contactUsRepository.getContactUs();
      emit(ContactUsStateSuccess());
    } on Exception catch (error) {
      emit(ContactUsStateFailure(error: error.toString()));
    }
  }
}
