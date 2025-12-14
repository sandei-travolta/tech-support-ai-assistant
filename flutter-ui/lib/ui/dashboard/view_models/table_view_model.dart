

import 'package:admin_panel/data/models/messageModel.dart';

import 'package:flutter/material.dart';

import '../../../data/repositories/MessagingRepositories.dart';

class TableViewModel extends ChangeNotifier {
  final MessagingRepositories _repositories;

  TableViewModel(this._repositories);

  List<MessageModel> messages = [];
  bool isLoading = false;
  String? error;

  int pageSize = 3; // 👈 dynamic number of items per page
  int start = 0;    // current offset

  Future<void> loadMessages() async {
    isLoading = true;
    notifyListeners();

    try {
      messages = await _repositories.fetchMessages();
    } catch (e) {
      error = e.toString();
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  int get currentPage => (start ~/ pageSize) + 1;
  int get totalPages =>
      (messages.length / pageSize).ceil();
  /// 🔹 What the UI should display
  List<MessageModel> get visibleMessages =>
      messages.skip(start).take(pageSize).toList();

  void nextPage() {
    if (start + pageSize >= messages.length) return;
    start += pageSize;
    notifyListeners();
  }

  void previousPage() {
    if (start == 0) return;
    start -= pageSize;
    notifyListeners();
  }
}
