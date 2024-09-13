// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tembea/features/Auth/controllers/auth_controller.dart';

import 'package:tembea/models/destination_model.dart';

class PopularDestination extends ConsumerWidget {
  final DestinationModel destination;

  const PopularDestination({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider);
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(destination.image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite,
                // color: user!.wishList!.contains(destination.name)
                //     ? Colors.red
                //     : Colors.white,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destination.name!,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                  Text(
                    destination.location!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_half,
                    size: 16,
                    color: Colors.yellow,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
