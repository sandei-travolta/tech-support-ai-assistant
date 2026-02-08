import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/conversations_page_model_view.dart';

class ConversationsTab extends StatelessWidget {
  const ConversationsTab({super.key, this.id, required this.closeChat});
  final String? id;
  final  VoidCallback closeChat;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConversationsPageModelView>();
    return Column(
      children: [
        // HEADER
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                id.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Expanded(child: Container()),
              IconButton(onPressed:closeChat, icon: Icon(Icons.close))
            ],
          ),
        ),
        // MESSAGES
        Expanded(
          child: Container(
            color: Colors.grey.shade50,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.conversationMessages.length,
              reverse: true, // Start from bottom like chat apps
              itemBuilder: (context, index) {
                final message = vm.conversationMessages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // USER MESSAGE
                    if (message.message.isNotEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message.message,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),

                    // BOT / RESPONSE MESSAGE
                    if (message.response != null && message.response!.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            message.response!,
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        // INPUT
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded),
                  color: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}