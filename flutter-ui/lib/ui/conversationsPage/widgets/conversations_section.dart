import 'package:flutter/material.dart';

import 'message_card.dart';
class ConversationsSection extends StatelessWidget {
  const ConversationsSection({
    super.key, required this.conversation, required this.selectChat,
  });
  final String? conversation;
  final void Function(String id) selectChat;
  @override
  Widget build(BuildContext context) {
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
                      itemCount: 3,
                      itemBuilder: (c,i){
                    return MessageCard(conversationId: i.toString(), selectChat: selectChat,selected: conversation==i.toString());
                  }),
                ),
              )
            ],
          ),
        ));
  }
}


