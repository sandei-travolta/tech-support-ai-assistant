import 'package:flutter/material.dart';

class BtnCard extends StatelessWidget {
  const BtnCard({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 50,
                spreadRadius: -12,
                offset: Offset(0, 25),
              )
            ],
          borderRadius: .circular(12.0)
        ),
        height: 150.0,
        width: 250.0,
        child:Center(child: Text(text))
    );
  }
}