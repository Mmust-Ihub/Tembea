import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/features/destination/controller/destination_controller.dart';
import 'package:tembea/core/widgets/destination.dart';
import 'package:tembea/features/destination/screens/detail_screen.dart';
import 'package:tembea/models/destination_model.dart';

// class ExploreScreen extends ConsumerStatefulWidget {
//   const ExploreScreen({super.key});

//   @override
//   ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends ConsumerState<ExploreScreen> {
//   final destinations = [];
//   void onTap(DestinationModel destination) {}

//   @override
//   Widget build(BuildContext context) {
//     final dests = ref.watch(destinationsProvider);
//     return Column(
//       children: [
//         const SizedBox(
//           height: 12,
//         ),
//         const Text(
//           "Explore",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               // color: Colors.red,
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   Expanded(
//                     // child: Container(color: Colors.blue,height: 10,),
//                     child: dests.when(
//                       data: (destination) => GridView.builder(

//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 6,
//                             mainAxisSpacing: 6,
//                             mainAxisExtent:
//                                 MediaQuery.of(context).size.height * 0.35),
//                         itemCount: destination.length,
//                         itemBuilder: (constext, index) {
//                           return Destination(
//                             destinationModel: destination[index],
//                             onTap: onTap,
//                           );
//                         },
//                       ),
//                       error: (e, s) => ErrorText(error: e.toString()),
//                       loading: () => const Loader(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});
  void addToWishList(WidgetRef ref, String destination, BuildContext context) {
    ref
        .watch(authControllerProvider.notifier)
        .addToWishList(destination: destination, context: context);
  }

  void changeScreen(BuildContext context, DestinationModel destinationModel) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(model: destinationModel)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dests = ref.watch(destinationsProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Explore",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                dests.when(
                  data: (destination) => SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        mainAxisExtent: MediaQuery.of(context).size.height * 0.38),
                    itemCount: destination.length,
                    itemBuilder: (context, index) {
                      return Destination(
                        destinationModel: destination[index],
                        onTap: () =>
                            addToWishList(ref, destination[index].name!, context),
                        changeScreen: () => changeScreen(context, destination[index]),
                      );
                    },
                  ),
                  error: (e, s) => SliverToBoxAdapter(
                      child: ErrorText(
                    error: e.toString(),
                  )),
                  loading: () => SliverToBoxAdapter(child: const Loader()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
