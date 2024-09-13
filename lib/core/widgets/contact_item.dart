import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String? value;
  final String name;
  const ContactItem({super.key, required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16,),
          ),
          Text(
            value!,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
