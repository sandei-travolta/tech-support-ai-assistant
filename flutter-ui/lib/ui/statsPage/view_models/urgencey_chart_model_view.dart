import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:admin_panel/domain/models/urgenceyModel.dart';
import 'package:flutter/cupertino.dart';

class UrgenceyChartModelView extends ChangeNotifier{
  final StatsRepository _repository;

  UrgenceyChartModelView({required StatsRepository repository}) : _repository = repository;
  List<UrgenceyModel> urgenceyList=[];
  bool isLoading=false;
  Future<void> fetchUrgencey()async{
    isLoading=true;
    notifyListeners();
    try{
      urgenceyList=await _repository.fetchUrgencey();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}