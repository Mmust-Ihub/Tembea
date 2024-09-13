import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tembea/core/constants/firebase_constants.dart';
import 'package:tembea/core/failure.dart';
import 'package:tembea/core/providers/firebase_provider.dart';
import 'package:tembea/core/type_def.dart';
import 'package:tembea/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider));
});

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersColection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    UserModel userModel;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userModel = UserModel(
          name: userCredential.user!.displayName!,
          profilePic: userCredential.user!.photoURL!,
          uid: userCredential.user!.uid,
          wishList: [],
          email: userCredential.user!.email ?? "no email");
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureEither<UserModel> signUpWithEmailAndPassword(
      String email, String password) async {
    UserModel userModel;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userModel = UserModel(
          name: userCredential.user!.displayName!,
          profilePic: userCredential.user!.photoURL!,
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? "no email",
          wishList: []);
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureEither<UserModel> signInWithGoogle() async {
    // print("inside repository");
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final googleAuth = await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // print("sign in info ${userCredential.user!.displayName}");
      UserModel userModel;
      // userCredential.user!.sendEmailVerification()
      // _auth.r
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: userCredential.user!.photoURL ?? "",
            uid: userCredential.user!.uid,
            wishList: [],
            location: "no location",
            email: userCredential.user!.email ?? "no email");
        await _users.doc(userModel.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }

      return right(userModel);

      // print(userCredential.user?.displayName);
    } on FirebaseException catch (e) {
      // print("Firebase error ${e.message}");
      throw e.message!;
    } catch (e) {
      // print("general error ${e.toString()}");
      return left(Failure(message: e.toString()));
    }
  }

  FutureVoid editProfile(UserModel model) async {
    try {
      return right(_users.doc(model.uid).update(model.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureVoid addToWishList(UserModel model) async {
    try {
      return right(_users.doc(model.uid).update(model.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureVoid removeFromWishList(UserModel model) async {
    try {
      return right(_users.doc(model.uid).update(model.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    print(_users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>)));
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
