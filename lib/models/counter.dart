
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

import '../services/database.dart';

class CountersModel extends Model {
  CountersModel({Stream<List<Counter>> stream}) {
    stream.listen((counters) {
      this.counters = counters;
      notifyListeners();
    });
  }

  List<Counter> counters;
}