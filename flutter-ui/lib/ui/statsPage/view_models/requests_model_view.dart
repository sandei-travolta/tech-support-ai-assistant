import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:admin_panel/domain/models/requestGraphModel.dart';
import 'package:flutter/cupertino.dart';

class RequestsModelView extends ChangeNotifier{
  final StatsRepository _repository;

  RequestsModelView({required StatsRepository repository}) : _repository = repository;
  List<RequestGraphModel> requests=[];
  bool isLoading=false;
  Future<void> fetchRequests()async{
    isLoading=true;
    notifyListeners();
    try{
      requests=await _repository.requestGraphModel();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}