import 'package:admin_panel/data/repositories/stats_repository.dart';
import 'package:admin_panel/domain/models/categoriesModel.dart';
import 'package:flutter/cupertino.dart';

class PieChartModelView extends ChangeNotifier{
  final StatsRepository _repository;
  final int _categories=0;
  bool isLoading = false;

  PieChartModelView({required StatsRepository repository}) : _repository = repository;
  List<CategoriesModel> categories=[];
  Future<void> fetchCategories()async{
    isLoading=true;
    notifyListeners();
    try {
      categories = await _repository.fetchCategories();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}