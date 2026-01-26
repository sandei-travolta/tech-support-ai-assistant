import 'package:admin_panel/ui/conversationsPage/widgets/conversations_section.dart';
import 'package:flutter/material.dart';

import 'widgets/chat_section.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        spacing: 15.0,
        children: [
          ConversationsSection(),
          ChatSection()
        ],
      ),
    );
  }
}


