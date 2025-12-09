import 'package:flutter/material.dart';

class PaginationCounter extends StatelessWidget {
  const PaginationCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        spacing: 25.0,
        mainAxisAlignment: .center,
        children: [
          Icon(
              size: 15.0,
              Icons.arrow_back),
          Text("1"),
          Icon(
              size: 15.0,
              Icons.arrow_forward)
        ],
      ),
    );
  }
}
