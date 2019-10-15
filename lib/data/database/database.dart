import 'package:moor/moor.dart';

part 'database.g.dart';

@UseMoor(
  tables: [],
  daos: [],
  include: {'tables.moor'},
  queries: {},
)
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          return await m.createAllTables();
        },
        onUpgrade: (m, from, to) async {
          switch (from) {
            case 3:
              // await m.addColumn(userRecords, userRecords.domain);
              break;
            default:
          }
          // m.deleteTable('loans');
          return await m.createAllTables();
        },
      );
}

Value<T> addField<T>(T val, {T fallback}) {
  Value<T> _fallback;
  if (fallback != null) {
    _fallback = Value<T>(fallback);
  }
  if (val == null) {
    return _fallback ?? Value.absent();
  }
  if (val is String && (val == 'null' || val == 'Null')) {
    return _fallback ?? Value.absent();
  }
  return Value(val);
}
