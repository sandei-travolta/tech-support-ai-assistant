import 'package:flutter/material.dart';

class TasksCard extends StatelessWidget {
  const TasksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: .circular(12.0)
      ),
      child: Column(
        children: [
          Expanded(child: Container(

          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: .circular(12.0),
                color: Colors.white
              ),
            ),
          ))
        ],
      ),
    );
  }
}
