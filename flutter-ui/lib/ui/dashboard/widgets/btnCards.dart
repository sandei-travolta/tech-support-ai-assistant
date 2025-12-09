import 'package:admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';

class BtnCard extends StatelessWidget {
  const BtnCard({
    super.key, required this.text,required this.color, required this.description
  });
  final String text;
  final Color color;
  final String description;
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
        child:Container(
            padding: .all(12.0),
            child: Column(
              crossAxisAlignment: .start,
            children: [
              Align(
                  alignment: .topLeft,
                  child: Text(text,style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: .w700
                  ),
                  )
              ),
              Text(description),
              Align(
                alignment: .center,
                child: RichText(
                    text: TextSpan(
                      text: '4',
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: .w800,
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: "issues",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: .w600,
                              color: Colors.black
                          ),
                        )
                      ]
                    )),
              )
            ],
          ))
    );
  }
}