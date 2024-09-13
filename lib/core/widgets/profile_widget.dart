import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';

class ProfileWidget extends ConsumerWidget {
  final String name;
  final String image;
  ProfileWidget({super.key, required this.name, required this.image});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image)),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.4)
                  // color: Colors.blue,
                  ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "Hello, $name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300),
          child: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                auth.signOut();
                ref.read(userProvider.notifier).update((state) => null);
              }),
        )
      ],
    );
  }
}
