import 'package:flutter/material.dart';

class TasksCard extends StatelessWidget {
  const TasksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 55.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: .circular(12.0)
        ),
        child: Column(
          children: [
            Expanded(child: Stack(
              children: [
                Container(
                  padding: .all(12.0),
                  child: Row(
                    children: [
                      Text("80%",style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: .w700
                      ),),
                      const SizedBox(width: 15.0),
                      Text("Requests Require\nHuman Intervation",style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,

                      ),)
                    ],
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 40,
                      width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: .circle
                  ),
                  child: Center(
                    child: Text("12",style: Theme.of(context).textTheme.labelLarge),
                  ),
                ))
              ],
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: .all(12.0),
                decoration: BoxDecoration(
                  borderRadius: .circular(12.0),
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Text("20%",style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.black54,
                        fontWeight: .w700
                    ),),
                    const SizedBox(width: 15.0),
                    Text("Requests Do not Require\nHuman Intervation",style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
