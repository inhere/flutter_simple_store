import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'base.dart';

/// init storage manager. file will save to user app-data directory.
///
/// eg: `simpleStore.init('app.json')`
Future<SimpleStore> init(String storeFilename) async {
  final appDataDir = await getApplicationDocumentsDirectory();
  final storagePath = p.join(appDataDir.path, storeFilename);

  final storageFile = File(storagePath);
  if (!storageFile.existsSync()) {
    storageFile.createSync();
  }

  try {
    final content = storageFile.readAsStringSync();
    final json = jsonDecode(content) as Map;
    return SimpleStoreImpl(storageFile, json.cast<String, Object>());
  } catch (e) {
    stderr.writeln('Error parsing local storage content, maybe is not a json file.');
    stderr.writeln(e);

    // init a new empty json file.
    storageFile.writeAsStringSync('{}');
    return SimpleStoreImpl(storageFile, <String, Object>{});
  }
}

/// SimpleStore implementation use file to store data.
class SimpleStoreImpl implements SimpleStore {
  final File _storageFile;
  final Map<String, Object> _storage;

  SimpleStoreImpl(this._storageFile, this._storage);

  @override
  int get length => _storage.length;

  void _saveFile() {
    final content = jsonEncode(_storage);
    _storageFile.writeAsStringSync(content);
  }

  @override
  void clear() {
    _storage.clear();
    _saveFile();
  }

  @override
  T? getItem<T>(String key) {
    return _storage[key] as T?;
  }

  @override
  void setItem(String key, Object value) {
    _storage[key] = value;
    _saveFile();
  }

  @override
  String? key(int index) {
    return _storage.keys.elementAt(index);
  }

  @override
  void removeItem(String key) {
    _storage.remove(key);
    _saveFile();
  }
}