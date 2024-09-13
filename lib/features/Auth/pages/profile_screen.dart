import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/utils.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/core/widgets/contact_item.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _edited = false;
  void updateProfile() {
    // final user = ref.watch(userProvider);
    setState(() {
      _edited = true;
    });
  }

  File? file;

  void selectImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        file = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        centerTitle: true,
        title: const Text("Profile"),
        leading: _edited
            ? TextButton(onPressed: () {}, child: const Text("SAVE  "))
            : const SizedBox(),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue.shade200,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                file != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(file!),
                        radius: 70,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 70,
                      ),
                // Positioned(
                //   bottom: 1,
                //   right: 1,
                //   child: IconButton(
                //     onPressed: () {
                //       selectImage();
                //     },
                //     iconSize: 32,
                //     icon: const Icon(
                //       Icons.camera_alt_outlined,
                //       color: Colors.blue,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          ContactItem(value: user.name, name: "Name"),
          const Divider(
            height: 1,
          ),

          ContactItem(
            value: user.email,
            name: "Email"
          ),
          // ContactItem(
          //   value: user.location,
          //   name: "Location"
          // ),
        ],
      ),
    );
  }
}
