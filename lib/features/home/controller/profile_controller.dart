import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tembea/core/providers/storage_repository_provider.dart';
import 'package:tembea/core/utils.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/features/home/repository/profile_repository.dart';
import 'package:tembea/models/user_model.dart';


final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  final destinationRepository = ref.read(profileRepositoryProvider);
  return ProfileController(
      ref: ref, profileRepository: destinationRepository, storageRepository: ref.read(storageRepositoryProvider));
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;

  ProfileController(
      {required Ref ref,
      required ProfileRepository profileRepository,
      required StorageRepository storageRepository})
      : _profileRepository = profileRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  void editProfile({
    required File? file,
    required String? name,
    required BuildContext context,
    required String? location,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    if (file != null) {
      final res = await _storageRepository.storeFile(
          path: "users/profile", id: user.uid, file: file);
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => user = user.copyWith(profilePic: r),
      );
    }
    if (location != null) {
      user = user.copyWith(location: location);
    }
    user = user.copyWith(name: name);
    final res = await _profileRepository.editProfile(user);
    state = false;
    res.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop());
  }
}
