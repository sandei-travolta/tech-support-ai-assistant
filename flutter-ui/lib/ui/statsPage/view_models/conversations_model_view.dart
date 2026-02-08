import 'package:admin_panel/data/models/messageModel.dart';
import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:flutter/cupertino.dart';

class ConversationsModelView extends ChangeNotifier{
  final StatsRepository _repository;

  ConversationsModelView({required StatsRepository repository}) : _repository = repository;
  bool isLoading=false;
  List<MessageModel> conversations=[];
  Future<void> fetchConversations()async{
    isLoading=true;
    notifyListeners();
    try{
      conversations=await _repository.fetchConversations();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}