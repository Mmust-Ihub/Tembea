import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tembea/core/failure.dart';
import 'package:tembea/core/providers/storage_repository_provider.dart';
import 'package:tembea/core/utils.dart';
import 'package:tembea/features/Auth/repositories/auth_repository.dart';
import 'package:tembea/models/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider),
        ref: ref,
        storageRepository: ref.watch(storageRepositoryProvider)));

final userProvider = StateProvider<UserModel?>((ref) {
  return null;
});

// final editProfileProvider = Provider((res)=>res.read(authControllerProvider.notifier).editProfile(file: file, context: context))

final authStateChangProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final userdataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  AuthController(
      {required AuthRepository authRepository,
      required StorageRepository storageRepository,
      required Ref ref})
      : _authRepository = authRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold((l) {
      print("message ${l.message}");
      //
      showSnackBar(context, l.message);
    }, (r) {
      _ref.read(userProvider.notifier).update((state) => r);
      // Routemaster.of(context).push("/");
    });
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user =
        await _authRepository.signInWithEmailAndPassword(email, password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(userProvider.notifier).update((state) => r);
      // Routemaster.of(context).push("/");
    });
  }

  void signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user =
        await _authRepository.signUpWithEmailAndPassword(email, password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(userProvider.notifier).update((state) => r);
      // Routemaster.of(context).push("/");
    });
  }

  void editProfile({required File? file, required BuildContext context}) async {
    final userModel = _ref.watch(userProvider);
    if (file != null) {
      final res = await _storageRepository.storeFile(
          path: "users/profile", id: userModel!.uid, file: file);
      res.fold((l) => showSnackBar(context, l.message),
          (r) => _authRepository.editProfile(userModel));
    }
  }

  void addToWishList(
      {required String destination, required BuildContext context}) async {
    final user = _ref.watch(userProvider)!;
    List<String> wishlist = user.wishList;
    UserModel userModel;
    Either<Failure, void> res;
    if (wishlist.isEmpty) {
      userModel = user.copyWith(wishList: [destination]);
      res = await _authRepository.addToWishList(userModel);
    }
    else if (user.wishList.contains(destination)) {
      wishlist.remove(destination);
      userModel = user.copyWith(wishList: wishlist);
      res = await _authRepository.removeFromWishList(userModel);
    } else {
      wishlist.add(destination);
      res = await _authRepository.addToWishList(user);
    }

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (user.wishList.contains(destination)) {
        showSnackBar(context, "Added to Wishlist");
      } else {
        showSnackBar(context, "Removed from Wishlist");
      }
    });
  }
}
