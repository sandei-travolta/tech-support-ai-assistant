import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top:5),
      child: Container(
        child: Row(
          spacing: 15.0,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: .circle,
                  color: Colors.grey
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text("+254792406400"),
                Container(
                    width: 250,
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut consectetur eros, eu congue enim.",
                    overflow: .ellipsis,
                    maxLines: 2,))
              ],
            ),
            Column(
              children: [
                Text("now"),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: .circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("1"),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}