import 'package:admin_panel/ui/conversationsPage/view_models/conversations_page_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message_card.dart';
class ConversationsSection extends StatefulWidget {
  const ConversationsSection({
    super.key, required this.conversation, required this.selectChat,
  });
  final String? conversation;
  final void Function(String id) selectChat;

  @override
  State<ConversationsSection> createState() => _ConversationsSectionState();
}

class _ConversationsSectionState extends State<ConversationsSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ConversationsPageModelView>().loadMessages();
    });
  }
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConversationsPageModelView>();
    return Expanded(
        flex: 2,
        child: Container(
          padding: .all(12.0),
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
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("All Conversations".toUpperCase(),style: TextStyle(
                fontSize: 18.0,
                fontWeight: .w700,
              ),),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount:vm.messages.length,
                      itemBuilder: (c,i){
                        final message=vm.messages[i];
                    return MessageCard(conversationId:message.sender.toString(), selectChat: widget.selectChat,selected: widget.conversation==i.toString(), messageModel: message,);
                  }),
                ),
              )
            ],
          ),
        ));
  }
}


