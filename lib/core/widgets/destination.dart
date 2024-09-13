import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/models/destination_model.dart';

class Destination extends ConsumerWidget {
  final DestinationModel destinationModel;

  final Function onTap;
  final Function changeScreen;
  const Destination(
      {super.key,
      required this.onTap,
      required this.destinationModel,
      required this.changeScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider)!;
    // final wish = (user.wishList! != null);
    Color color = Colors.red;
    return GestureDetector(
      onTap: () {
        changeScreen();
      },
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: .5)),
        height: 400,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(destinationModel.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinationModel.name ?? "",
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      Text(destinationModel.location ?? ""),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ksh ${destinationModel.price}"),
                      const Row(
                        children: [
                          Text("4"),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          Text("(4)"),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onTap();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(color: color, width: 0.5),
                        )),
                    child: Icon(
                      Icons.favorite_outline_outlined,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
