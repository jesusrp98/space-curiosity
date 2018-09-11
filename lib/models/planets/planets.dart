import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'celestial_body.dart';

var planetsPath = Firestore.instance.collection('planets');

class PlanetsModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<CelestialBody> _planets;
  List<CelestialBody> get planets => _planets;

  Future loadData() async {
    _isLoading = true;
    notifyListeners();
    var _snapshot = await planetsPath.getDocuments();
    _planets = _snapshot.documents
        .map((DocumentSnapshot document) => CelestialBody.fromJson(document))
        .toList();
    for (var planet in _planets) {
      _snapshot = await planetsPath
          .document(planet.id)
          .collection('moons')
          .getDocuments();
      planet.moons = _snapshot.documents
          .map((DocumentSnapshot document) => CelestialBody.fromJson(document))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}
