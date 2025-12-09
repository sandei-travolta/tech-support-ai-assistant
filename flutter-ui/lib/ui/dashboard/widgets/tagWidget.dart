import 'package:flutter/material.dart';

class TagWidgets extends StatelessWidget {
  const TagWidgets({
    super.key,
    required this.text
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
    );
  }
}
