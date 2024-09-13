import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/features/destination/controller/destination_controller.dart';

class FavouriteItem extends ConsumerWidget {
  final String wishList;

  const FavouriteItem({super.key, required this.wishList});
  void addToWishList(WidgetRef ref, String destination, BuildContext context) {
    ref
        .watch(authControllerProvider.notifier)
        .addToWishList(destination: destination, context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(destinationProvider(wishList)).when(
        data: (data) {
          return Container(
            margin: const EdgeInsets.only(top: 3, right: 12, left: 12),
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data.image!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width:12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.name}",
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade400,
                          ),
                          Text("${data.location}"),
                        ],
                      ),
                      Text("Ksh ${data.price}"),
                      MaterialButton(
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        onPressed: () {
                          addToWishList(ref, data.name!, context);
                        },
                        color: Colors.red.shade400,
                        child: const Text("Remove",style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        error: (error, s) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
