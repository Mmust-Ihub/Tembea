import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/features/destination/controller/destination_controller.dart';
import 'package:tembea/core/widgets/category_item.dart';
import 'package:tembea/core/widgets/popular_destination.dart';
/*
class MyLocationScreen extends ConsumerStatefulWidget {
  const MyLocationScreen({super.key});

  @override
  ConsumerState<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends ConsumerState<MyLocationScreen> {
  final List<Map<String, String>> categories = [
    {"name": "Camping", "image": "assets/images/camping.png"},
    {"name": "Beach", "image": "assets/images/beach.png"},
    {"name": "Hiking", "image": "assets/images/hike.png"},
    {"name": "Birding", "image": "assets/images/birds.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final dests = ref.watch(destinationsProvider);
    final name = user!.name.split(" ")[0];
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(user.profilePic)),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 0.4)
                              // color: Colors.blue,
                              ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hello, $name",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Nakuru,Kenya",
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade300),
                          child:
                              const Icon(Icons.notifications_active_outlined),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "It's time for Travelling\nPlan your \nvacation now!",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            "50% OFF",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Choose Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blue[300]),
                        ),
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
                        "Nearby Locations",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blue[300]),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: dests.when(
                      data: (destination) {
                        // print("Destination count: ${destination.length}");
                        return GridView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height *
                                          0.35),
                          itemCount: destination.length,
                          itemBuilder: (constext, index) {
                            return PopularDestination(
                                destination: destination[index]);
                          },
                        );
                      },
                      error: (e, s) => ErrorText(error: e.toString()),
                      loading: () => const Loader(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
 
class MyLocationScreen extends ConsumerStatefulWidget {
  const MyLocationScreen({super.key});

  @override
  ConsumerState<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends ConsumerState<MyLocationScreen> {
  final List<Map<String, String>> categories = [
    {"name": "Camping", "image": "assets/images/camping.png"},
    {"name": "Beach", "image": "assets/images/beach.png"},
    {"name": "Hiking", "image": "assets/images/hike.png"},
    {"name": "Birding", "image": "assets/images/birds.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final dests = ref.watch(destinationsProvider);
    final name = user!.name.split(" ")[0];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(user.profilePic)),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 0.4)
                                // color: Colors.blue,
                                ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hello, $name",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Nakuru,Kenya",
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                            child:
                                const Icon(Icons.notifications_active_outlined),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "It's time for Travelling\nPlan your \nvacation now!",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "50% OFF",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),const Row(
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
                  ],
                ),
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
            error: (e, s) => SliverToBoxAdapter(child: ErrorText(error: e.toString())),
            loading: () => const SliverToBoxAdapter(child: Loader()),
          )
              
            ]),
          ),
          
        ],
      ),
    );
  }
}
