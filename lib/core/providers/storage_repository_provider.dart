import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tembea/core/failure.dart';
import 'package:tembea/core/providers/firebase_provider.dart';
import 'package:tembea/core/type_def.dart';

final storageRepositoryProvider = Provider((ref) {
  return StorageRepository(firebaseStorage: ref.read(storageProvider));
});

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile(
      {required String path, required String id, required File? file}) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
    UploadTask task = ref.putFile(file!);
    final snapshot = await task;
    return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
