import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: isHovered ? 300 : 50),
          curve: isHovered ? Curves.easeOutCubic : Curves.easeInCubic,
          tween: Tween(begin: 0.0, end: isHovered ? 1.0 : 0.0),
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.lerp(
                  Colors.transparent,
                  Colors.grey.shade100,
                  value,
                ),
                boxShadow: value > 0
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12 * value),
                    blurRadius: 12 * value,
                    offset: Offset(0, 4 * value),
                  )
                ]
                    : null,
              ),
              child: child,
            );
          },
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("+254792406400"),
                    SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut consectetur eros, eu congue enim.",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              const Column(
                children: [
                  Text("now"),
                  SizedBox(height: 5),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}