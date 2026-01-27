import 'package:admin_panel/ui/conversationsPage/widgets/conversations_tab.dart';
import 'package:flutter/material.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({
    super.key, required this.isVisible, required this.id, required this.closeChat,
  });
  final bool isVisible;
  final String? id;
  final VoidCallback closeChat;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: .circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(50, 50, 93, 0.25),
                  blurRadius: 27,
                  spreadRadius: -5,
                  offset: Offset(0, 13),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  blurRadius: 16,
                  spreadRadius: -8,
                  offset: Offset(0, 8),
                )
              ],

          ),
          child: Center(
            child: isVisible?ConversationsTab(id: id, closeChat: closeChat):Text("Select Conversation"),
          ),
        ));
  }
}
