import 'package:admin_panel/ui/dashboard/view_models/cards_view_model.dart';
import 'package:admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BtnCard extends StatelessWidget {
  const BtnCard({
    super.key, required this.text,required this.color, required this.description, required this.data
  });
  final String text;
  final Color color;
  final String description;
  final int data;
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
                      text: data.toString(),
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: .w800,
                        color: Colors.black
                      ),
                      children: [
                        WidgetSpan(

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(text),
                          ),
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