import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'planet.dart';

class PlanetsModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Planet> _planets;
  List<Planet> get planets => _planets;

  Future loadData() async {
    _isLoading = true;
    notifyListeners();
    var _snapshot =
        await Firestore.instance.collection('planets').getDocuments();
    _planets = _snapshot.documents
        .map((DocumentSnapshot document) => Planet.fromJson(document))
        .toList();
    _isLoading = false;
    notifyListeners();
  }
}
