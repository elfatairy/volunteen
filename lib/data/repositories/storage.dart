import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage firebaseStorage;
  StorageRepository({required this.firebaseStorage});

  Future<void> uploadImage(File file, String uploadReference) async {
    final storageRef = firebaseStorage.ref();
    final uploadRef = storageRef.child("/$uploadReference");
    await uploadRef.putFile(file);
  }

  Future<Reference?> getImage(String imageReference) async {
    final uploadReference = firebaseStorage.ref().child("/$imageReference");
    final uploadedImage = await uploadReference.listAll();
    return uploadedImage.items.first;
  }

  Future<List<Reference?>> getImages(String folderReference) async {
    final uploadReference = firebaseStorage.ref().child('/$folderReference');
    final uploadedImages = await uploadReference.listAll();
    return uploadedImages.items;
  }

  Future<void> deleteImage(String imageReference) async {
    final imageRef = firebaseStorage.ref().child("/$imageReference");
    await imageRef.delete();
  }

  Future<void> deleteFolder(String folderReference) async {
    try {
      final folderRef = firebaseStorage.ref().child('/$folderReference');

      final ListResult folderContents = await folderRef.listAll();

      for (final Reference file in folderContents.items) {
        await file.delete();
      }

      for (final Reference subfolder in folderContents.prefixes) {
        await deleteFolder(subfolder.fullPath);
      }
    } catch (e) {
      throw Exception("Error deleting folder: $e");
    }
  }
}
