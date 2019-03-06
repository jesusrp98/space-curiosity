import '../../repositories/persistence_repository.dart';

export '../../file_storage.dart';

abstract class PersistData {
  String get module => null;

  final PersistenceRepository storage = PersistenceRepository(
    fileStorage: null,
  );

  bool loading = false;
  bool loaded = false;

  Future loadFromDisk() async {}

  void saveToDisk() {}
}
