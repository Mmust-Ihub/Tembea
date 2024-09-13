import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';
import 'package:tembea/models/destination_model.dart';

class DetailScreen extends StatelessWidget {
  final DestinationModel model;
  const DetailScreen({super.key, required this.model});

  // final data = Routemaster.of(context).

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 0.6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.favorite_outline_outlined,size: 32,),
            )
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(model.image!, fit: BoxFit.cover),
              ),
              SizedBox(height: 12,),
              Text(
                model.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                   Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey.shade400
                      ),
                  Text(
                    model.location!,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "23 Reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Text(
                model.descreption ?? "",
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    Text(
                      "KSH ${model.price!}/Person",
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.blue,
                  child: const Text(
                    "Add to Wishlist",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
