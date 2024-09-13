import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/core/widgets/favourite_item.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishes = ref.watch(userProvider)!.wishList;

    print("Wishlist $wishes");
    if (wishes.isEmpty) {
      return const Center(child: Text("You wishlist is empty"));
    } else {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
            children:
                wishes.map((wish) => FavouriteItem(wishList: wish)).toList(),
          ),
          )
        ],
      );
    }
  }
}
