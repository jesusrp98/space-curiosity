import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

abstract class QuerryModel extends Model {
  List _items = List();
  List _images = List();
  List snapshot;
  var response;
  bool _loading = true;

  Future refresh() async {
    clearLists();
    await loadData();
    notifyListeners();
  }

  void loadingState(bool state) {
    _loading = state;
    notifyListeners();
  }

  Future loadData();

  List get items => _items;

  List get images => _images;

  String getImageUrl(index) => _images[index];

  int get getImagesCount => _images.length;

  int get getSize => _items.length;

  dynamic getItem(index) => _items[index];

  bool get isLoading => _loading;

  clearLists() {
    _items.clear();
    _images.clear();
  }
}
