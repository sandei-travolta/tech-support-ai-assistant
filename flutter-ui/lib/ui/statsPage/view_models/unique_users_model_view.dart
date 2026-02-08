import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:flutter/cupertino.dart';

class UniqueUsersModelView extends ChangeNotifier{
  final StatsRepository _repository;

  UniqueUsersModelView({required StatsRepository repository}) : _repository = repository;
  bool isLoading=false;
  int users=0;
  Future<void> fetchUsers()async{
    isLoading=true;
    notifyListeners();
    try{
      users=await _repository.fetchUniqueUsers();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}