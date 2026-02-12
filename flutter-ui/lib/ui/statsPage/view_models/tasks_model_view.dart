import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:flutter/material.dart';

class TasksModelView extends ChangeNotifier{
  double humanRatio=0.0;
  final StatsRepository _repository;
  int totalRequests=0;
  bool isLoading=false;

  TasksModelView({required StatsRepository repository}) : _repository = repository;
  Future<void> fetchHumanRation()async{
    isLoading=true;
    notifyListeners();
    try{
      humanRatio=await _repository.classifyRequests();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
  Future<void> fetchTotalMessages()async{
    try{
      totalRequests=await _repository.fetchTotalRequests();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }
  }
}