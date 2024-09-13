import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/features/destination/controller/destination_controller.dart';
import 'package:tembea/core/widgets/category_item.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/core/widgets/popular_destination.dart';
import 'package:tembea/core/widgets/profile_widget.dart';
import 'package:tembea/features/destination/delegates/search_destination_delegate.dart';

// class HomeScreen extends ConsumerWidget {
//   HomeScreen({super.key});

//   final List<Map<String, String>> categories = [
//     {"name": "Camping", "image": "assets/images/camping.png"},
//     {"name": "Beach", "image": "assets/images/beach.png"},
//     {"name": "Hiking", "image": "assets/images/hike.png"},
//     {"name": "Birding", "image": "assets/images/birds.png"},
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);
//     final dests = ref.watch(destinationsProvider);

//     final name = user!.name.split(" ")[0];

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: EdgeInsets.only(top: 14),
//               child: Column(
//                 children: [
//                   ProfileWidget(
//                     name: name,
//                     image: user.profilePic,
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(right: 32),
//                     child: const Text(
//                       "Where do you \nwant to explore today?",
//                       style:
//                           TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                         hintText: "Search Destination",
//                         hintStyle: const TextStyle(color: Colors.grey),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                               width: 0.6, color: Colors.blue.shade400),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                               width: 0.6, color: Colors.grey.shade400),
//                         ),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.grey.shade400,
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Choose Category",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "See all",
//                           style:
//                               TextStyle(fontSize: 16, color: Colors.blue[300]),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: categories
//                         .map(
//                           (category) => CategoryItem(
//                               name: category["name"], image: category["image"]),
//                         )
//                         .toList(),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Popular Destination",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "See all",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.blue[300],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                             child: dests.when(
//                           data: (destination) => GridView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 6,
//                                     mainAxisSpacing: 6,
//                                     mainAxisExtent:
//                                         MediaQuery.of(context).size.height *
//                                             0.35),
//                             itemCount: destination.length,
//                             itemBuilder: (constext, index) {
//                               return PopularDestination(
//                                   destination: destination[index]);
//                             },
//                           ),
//                           error: (e, s) => ErrorText(error: e.toString()),
//                           loading: () => const Loader(),
//                         )),
//                       ],
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

//   void onTap() {}
// }

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> categories = [
    {"name": "Camping", "image": "assets/images/camping.png"},
    {"name": "Beach", "image": "assets/images/beach.png"},
    {"name": "Hiking", "image": "assets/images/hike.png"},
    {"name": "Birding", "image": "assets/images/birds.png"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final dests = ref.watch(destinationsProvider);

    final name = user!.name.split(" ")[0];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              
              slivers: [
                SliverToBoxAdapter(
                  child: Column(children: [
                    ProfileWidget(
                      name: name,
                      image: user.profilePic,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 32),
                      child: const Text(
                        "Where do you \nwant to explore today?",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () => showSearch(
                          context: context,
                          delegate: SearchDestinationDelegate(ref: ref)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 0.6, color: Colors.blue.shade400),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                            ),
                            const Text("Search Destination",
                                style: TextStyle(color: Colors.grey, fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Category",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: categories
                          .map((category) => CategoryItem(
                              name: category["name"], image: category["image"]))
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Destination",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ]),
                ),
                dests.when(
                    data: (destination) => SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          mainAxisExtent: MediaQuery.of(context).size.height * 0.35),
                      itemCount: destination.length,
                      itemBuilder: (constext, index) {
                        return PopularDestination(destination: destination[index]);
                      },
                    ),
                    error: (e, s) => SliverToBoxAdapter(child: ErrorText(error: e.toString(),)),
                    loading: () => SliverToBoxAdapter(child:const Loader()),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
