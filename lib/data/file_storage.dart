import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:recase/recase.dart';

class FileStorage {
  final String tag;

  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag, {
    this.getDirectory,
  });

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    var _path = p.joinAll([path, "${ReCase(tag).camelCase}.json"]);
    return File(_path);
  }

  Future<dynamic> load() async {
    final file = await _localFile;
    final contents = await file.readAsString();
    return contents;
  }

  Future<File> save(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

  Future<FileSystemEntity> delete() async {
    final file = await _localFile;

    return file.delete();
  }

  Future<bool> exists() async {
    final file = await _localFile;

    return file.exists();
  }
}
