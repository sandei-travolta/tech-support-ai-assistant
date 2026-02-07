import 'package:admin_panel/data/models/messageModel.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.conversationId,
    required this.selectChat,
    required this.selected,
    required this.messageModel,
  });
  final MessageModel messageModel;
  final String? conversationId;
  final void Function(String id) selectChat;
  final bool selected;

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
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: widget.selected ? 200 : (isHovered ? 300 : 50)),
          curve: widget.selected || isHovered ? Curves.easeOutCubic : Curves.easeInCubic,
          tween: Tween(begin: 0.0, end: (widget.selected || isHovered) ? 1.0 : 0.0),
          builder: (context, value, child) {
            return InkWell(
              onTap: () => widget.selectChat(widget.conversationId!),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.selected
                      ? Colors.blue.shade50
                      : Color.lerp(
                    Colors.transparent,
                    Colors.grey.shade100,
                    value,
                  ),
                  border: widget.selected
                      ? Border.all(
                    color: Colors.blue.shade300,
                    width: 2,
                  )
                      : null,
                  boxShadow: value > 0 || widget.selected
                      ? [
                    BoxShadow(
                      color: widget.selected
                          ? Colors.blue.withOpacity(0.15)
                          : Colors.black.withOpacity(0.12 * value),
                      blurRadius: widget.selected ? 8 : 12 * value,
                      offset: Offset(0, widget.selected ? 2 : 4 * value),
                    )
                  ]
                      : null,
                ),
                child: child,
              ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.messageModel.sender,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.messageModel.message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              const Column(
                children: [
                  Text(
                    "now",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
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