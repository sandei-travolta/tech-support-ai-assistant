import 'dart:convert';

import 'package:admin_panel/config/urlConfig.dart';
import 'package:admin_panel/data/models/messageModel.dart';
import 'package:http/http.dart' as http;

class MessagingService{
  Future<List<MessageModel>> fetchMessages()async{
    final response=await http.get(Uri.parse('${UrlConfig.BASE_URL}/messaging/messages'));
    if(response.statusCode==200){
      final List data=json.decode(response.body);

      return data.map((e)=>MessageModel.fromJson(e)).toList();
    }else{
      throw Exception(response.body);
    }
  }
  Future<List<MessageModel>> fetchConversation()async{
    final res=await http.get(Uri.parse('${UrlConfig.BASE_URL}/messaging/conversations'));
    if(res.statusCode==200){
      final List data=json.decode(res.body);
      return data.map((e)=>MessageModel.fromJson(e)).toList();
    }
    else{
      throw Exception(res.statusCode);
    }
  }
  Future<List<MessageModel>> fetchConversationMessages(String uid)async{
    final res=await http.get(Uri.parse('${UrlConfig.BASE_URL}/messaging/messages/${uid}'));
    if(res.statusCode==200){
      final List data=json.decode(res.body);
      return data.map((e)=>MessageModel.fromJson(e)).toList();
    }
    else{
      throw Exception(res.statusCode);
    }
  }
}
