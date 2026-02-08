import 'package:flutter/material.dart';

import '../../../data/models/messageModel.dart';
import '../../../data/repositories/messaging_repositories.dart';

class ConversationsPageModelView extends ChangeNotifier{
  final MessagingRepositories _repositories;
  bool _active=false;
  String? _currentChat;

  ConversationsPageModelView(this._repositories);
  List<MessageModel> messages = [];
  List<MessageModel> conversationMessages = [];
  bool isLoading = false;
  String? error;
  Future<void> loadMessages() async {
    isLoading = true;
    notifyListeners();

    try {
      messages = await _repositories.fetchConversations();
    } catch (e) {
      error = e.toString();
      print(error);
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
  Future<void> loadConversationMessages() async {
    isLoading = true;
    try {
      conversationMessages = await _repositories.fetchConversationMessages(_currentChat!);
    } catch (e) {
      error = e.toString();
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  bool get active => _active;

  set active(bool value) {
    _active = value;
    notifyListeners();
  }

  String? get currentChat => _currentChat;

  set currentChat(String value) {
    _currentChat = value;
    notifyListeners();
  }
  void openChat(String id) {
    _currentChat = id;
    _active = true;
    loadConversationMessages();
    notifyListeners();
  }
  void closeChat() {
    _active = false;
    _currentChat = null;
    notifyListeners();
  }
}