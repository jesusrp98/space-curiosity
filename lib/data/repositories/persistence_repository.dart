import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  // Future<File> saveState(DataSourceModule data) async {
  //   return await fileStorage.save(json.encode(data));
  // }

  // Future<DataSourceModule> loadState() async {
  //   String data = await fileStorage.load();
  //   return DataSourceModule.fromJson(json.decode(data));
  // }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exists()
        .then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exists();
  }
}
