import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:flutter/material.dart';

class CardsViewModel extends ChangeNotifier{
  final StatsRepository _repository;

  CardsViewModel({required StatsRepository repository}) : _repository = repository;
  int uniqueUsers=0;
  bool fetchingUniqueUsers=false;
  int totalRequests=0;
  bool fetchingRequests=false;
  int conversations=0;
  bool fetchingConversations=false;
  Future<void> fetchConversationCount()async{
    fetchingConversations=true;
    notifyListeners();
    try{
      final c=await _repository.fetchConversations();
      conversations=c.length;
    }
    catch(e){
      print(e.toString());
    }finally{
      fetchingConversations=false;
      notifyListeners();
    }
  }
  Future<void> fetchRequest()async{
    fetchingRequests=true;
    notifyListeners();
    try{
      totalRequests=await _repository.fetchTotalRequests();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      fetchingRequests=false;
      notifyListeners();
    }
  }
  Future<void> fetchUniqueUsers()async{
    fetchingUniqueUsers=true;
    notifyListeners();
    try{
      uniqueUsers=await _repository.fetchUniqueUsers();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      fetchingUniqueUsers=false;
      notifyListeners();
    }
  }
}