import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagWidgets extends StatelessWidget {
  const TagWidgets({
    super.key,
    required this.text, required this.asset
  });
  final String text;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        spacing: 2.5,
        children: [
          SvgPicture.asset(
              "resources/svgs/${asset}.svg",
            width: 15,
            height: 15,
          ),
          Text(text,style: TextStyle(
            fontSize: 12.0,
            fontWeight: .w600
          ),),
        ],
      ),
    );
  }
}
