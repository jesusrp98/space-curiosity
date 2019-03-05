import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../classes/nasa/list.dart';
import '../file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveNasaImagesState(NasaImages data) async {
    return await fileStorage.save(json.encode(data));
  }

  Future<NasaImages> loadNasaImagesState() async {
    String data = await fileStorage.load();
    return NasaImages.fromJson(json.decode(data));
  }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exists()
        .then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exists();
  }
}
