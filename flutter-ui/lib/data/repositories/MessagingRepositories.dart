import 'package:admin_panel/data/models/messageModel.dart';
import 'package:admin_panel/data/services/messageService.dart';

class MessagingRepositories {
  final MessagingService _service;

  MessagingRepositories(this._service);
  Future<List<MessageModel>> fetchMessages(){
    return _service.fetchMessages();
  }
  Future<List<MessageModel>> fetchConversations(){
    return _service.fetchConversation();
  }
  Future<List<MessageModel>> fetchConversationMessages(String uid){
    return _service.fetchConversationMessages(uid);
  }
}