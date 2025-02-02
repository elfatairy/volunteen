import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:volunteen/data/repositories/storage.dart';

part 'state.dart';

class ImageLoaderHandler extends Cubit<ImageLoaderState> {
  final StorageRepository storageRepository;
  ImageLoaderHandler({required this.storageRepository})
      : super(ImageLoaderStateInitial());

  Future<String> getImage(final String path) async {
    emit(ImageLoaderStateLoading());
    try {
      Reference? imageReference = await storageRepository.getImage(path);
      if (imageReference != null) {
        final String imageURL = await imageReference.getDownloadURL();
        emit(ImageLoaderStateSuccess());
        return imageURL;
      }
    } on Exception catch (error) {
      emit(ImageLoaderStateFailure(error: error.toString()));
      return '';
    }
    emit(const ImageLoaderStateFailure(error: 'Failed to load image'));
    return '';
  }
}
