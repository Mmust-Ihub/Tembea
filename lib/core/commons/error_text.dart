import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    // print(error);
    return Center(
      child: Text(
        error,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
