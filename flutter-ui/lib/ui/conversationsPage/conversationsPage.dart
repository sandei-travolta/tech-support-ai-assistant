import 'package:admin_panel/ui/conversationsPage/view_models/conversations_page_model_view.dart';
import 'package:admin_panel/ui/conversationsPage/widgets/conversations_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/chat_section.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConversationsPageModelView>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          spacing: 15.0,
          children: [
            ConversationsSection(conversation: vm.currentChat, selectChat:vm.openChat),
            ChatSection(isVisible: vm.active, id: vm.currentChat,closeChat: vm.closeChat,)
          ],
        ),
      ),
    );
  }
}


