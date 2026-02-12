import 'package:admin_panel/data/models/messageModel.dart';
import 'package:admin_panel/data/services/messageService.dart';
import 'package:admin_panel/domain/models/categoriesModel.dart';
import 'package:admin_panel/domain/models/requestGraphModel.dart';
import 'package:admin_panel/domain/models/urgenceyModel.dart';

class StatsRepository {
  final MessagingService _messagingService;

  StatsRepository(this._messagingService);
  Future<List<CategoriesModel>> fetchCategories() async {
    final messages = await _messagingService.fetchMessages();

    final Map<String, int> freq = {};

    for (final message in messages) {
      final tag = message.tags;
      if (tag != null && tag.isNotEmpty) {
        freq[tag] = (freq[tag] ?? 0) + 1;
      }
    }

    return freq.entries.map((entry) {
      return CategoriesModel(
        category: entry.key,
        f: entry.value,
      );
    }).toList();
  }

  Future<double> classifyRequests()async{
    List<CategoriesModel> categories=await fetchCategories();
    int human=0;
    for (final c in categories){
      if(c.category.toLowerCase()=="Network & Connectivity".toLowerCase()){
        human++;
      }
    }
    List<MessageModel> totalMessages=await _messagingService.fetchMessages();
    return human/totalMessages.length;
  }
  Future<int> fetchUniqueUsers()async{
    List<MessageModel> c=await _messagingService.fetchConversation();
    return  c.length;
  }
  Future<int> fetchTotalRequests()async{
    List<MessageModel> c=await _messagingService.fetchMessages();
    return c.length;
  }
  Future<List<MessageModel>> fetchAllMessages()async{
    return _messagingService.fetchMessages();
  }
  Future<List<RequestGraphModel>> requestGraphModel() async {
    final List<MessageModel> messages = await fetchAllMessages();

    final DateTime today = DateTime.now();
    final DateTime startDate = today.subtract(const Duration(days: 6));

    // Prepare a map: day -> count
    final Map<DateTime, int> dailyCounts = {};

    // Initialize all 7 days with 0
    for (int i = 0; i < 7; i++) {
      final day = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + i,
      );
      dailyCounts[day] = 0;
    }

    // Count messages per day
    for (final msg in messages) {
      final d = DateTime(
        msg.timestamp.year,
        msg.timestamp.month,
        msg.timestamp.day,
      );

      if (dailyCounts.containsKey(d)) {
        dailyCounts[d] = dailyCounts[d]! + 1;
      }
    }

    // Build graph models
    final List<RequestGraphModel> models = dailyCounts.entries.map((entry) {
      return RequestGraphModel(
        day: entry.key.day,
        requests: entry.value,
      );
    }).toList();

    return models;
  }
  Future<List<UrgenceyModel>> fetchUrgencey() async {
    final List<MessageModel> messages = await fetchAllMessages();


    final Map<String, int> freq = {
      "low": 0,
      "medium": 0,
      "high": 0,
      "critical": 0,
    };


    for (final m in messages) {
      final urgency = m.urgencey?.toLowerCase();
      if (urgency != null && freq.containsKey(urgency)) {
        freq[urgency] = freq[urgency]! + 1;
      }
    }

    return freq.entries.map((entry) {
      return UrgenceyModel(
        urgencey: entry.key,
        f: entry.value,
      );
    }).toList();
  }
  Future<List<MessageModel>> fetchConversations()async{
    return _messagingService.fetchConversation();
  }
}