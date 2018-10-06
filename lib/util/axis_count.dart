import 'package:flutter/material.dart';

int getAxisCount(BuildContext context) {
  final _width = MediaQuery.of(context).size.width;
  if (_width <= 500.0) return 2;
  if (_width <= 800.0) return 3;
  if (_width <= 1100.0) return 4;
  return 5;
}
