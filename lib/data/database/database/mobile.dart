import 'package:moor_flutter/moor_flutter.dart';

import '../database.dart';

Database constructDb({bool logStatements = false}) {
  // if (Platform.isIOS || Platform.isAndroid) {
  //   final executor = LazyDatabase(() async {
  //     final dataDir = await paths.getApplicationDocumentsDirectory();
  //     final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
  //     return VmDatabase(dbFile, logStatements: logStatements);
  //   });
  //   return Database(executor);
  // }
  // if (Platform.isMacOS || Platform.isLinux) {
  //   final file = File('db.sqlite');
  //   return Database(VmDatabase(file, logStatements: logStatements));
  // }
  // return Database(VmDatabase.memory(logStatements: logStatements));
  return Database(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
}
