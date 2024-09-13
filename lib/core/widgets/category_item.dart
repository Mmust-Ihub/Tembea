import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String? name;
  final String? image;
  const CategoryItem({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height * 0.08);
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue,
              image: DecorationImage(image:AssetImage(
                image!,
              ),fit: BoxFit.cover,)
            ),
            // child: Image.asset(), 
          ),
          const SizedBox(
            height: 8,
          ),
          Text(name!)
        ],
      ),
    );
  }
}
