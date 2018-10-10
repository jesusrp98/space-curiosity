import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../scoped_model/general_model.dart';
import 'celestial_body.dart';

var planetsPath = Firestore.instance.collection('planets');

class PlanetsModel extends GeneralModel {
  Future loadData() async {
    final response = await planetsPath.getDocuments();

    list.addAll(response.documents
        .map((document) => CelestialBody.fromJson(document))
        .toList());

    loadingState(false);
  }
}
