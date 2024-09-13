import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tembea/core/constants/firebase_constants.dart';
import 'package:tembea/core/failure.dart';
import 'package:tembea/core/providers/firebase_provider.dart';
import 'package:tembea/core/type_def.dart';
import 'package:tembea/models/user_model.dart';

final profileRepositoryProvider = Provider(
    (ref) => ProfileRepository(firestore: ref.read(firestoreProvider)));

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersColection);

  FutureVoid editProfile(UserModel userModel) async {
    try {
      return right(_users.doc(userModel.uid).update(userModel.toMap()));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
