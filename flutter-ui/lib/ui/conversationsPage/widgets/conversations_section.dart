import 'package:flutter/material.dart';
class ConversationsSection extends StatelessWidget {
  const ConversationsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: .circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(50, 50, 93, 0.25),
                    blurRadius: 100,
                    spreadRadius: -20,
                    offset: Offset(0, 50),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 60,
                    spreadRadius: -30,
                    offset: Offset(0, 30),
                  )
                ]
            ),
          ),
        ));
  }
}
