import 'package:flutter/material.dart';

class ConversationsPageModelView extends ChangeNotifier{
  bool _active=false;
  String? _currentChat;

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
    notifyListeners();
  }
  void closeChat() {
    _active = false;
    _currentChat = null;
    notifyListeners();
  }
}