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
      padding: .symmetric(vertical:5.0,horizontal:10.0),
      decoration: BoxDecoration(
          border: .all(
            width:0.2,
            color:Colors.grey
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(33, 35, 38, 0.1),
              blurRadius: 10,
              spreadRadius: -10,
              offset: Offset(0, 10),
            )
          ],
        borderRadius: BorderRadius.circular(12),
      ),
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
