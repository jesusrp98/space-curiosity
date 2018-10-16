import 'dart:async';

import 'package:scoped_model/scoped_model.dart';


abstract class QuerryModel extends Model {
  List _list = List();
  var response;
  bool _loading = true;

  Future refresh() async {
    await loadData();
    notifyListeners();
  }

  void loadingState(bool state) {
    _loading = state;
    notifyListeners();
  }

  Future loadData();

  List get list => _list;

  int get getSize => _list.length;

  bool get isLoading => _loading;
}
