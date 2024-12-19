import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'base.dart';

/// init storage manager. file will save to user app-data directory.
Future<SimpleStore> init(String storeFilename) async {
  var storagePath = storeFilename;
  if (!p.isAbsolute(storeFilename)) {
    final appDataDir = await getApplicationDocumentsDirectory();
    storagePath = p.join(appDataDir.path, storeFilename);
  }

  final storageFile = File(storagePath);

  // check file exists.
  if (!storageFile.existsSync()) {
    storageFile.createSync(recursive: true);
    return _initEmpty(storageFile);
  }

  try {
    final contents = storageFile.readAsStringSync();
    final jsonMap = jsonDecode(contents) as Map;
    return SimpleStoreImpl(storageFile, jsonMap.cast<String, Object>());
  } catch (e) {
    stderr.writeln('simple_store: Error parsing local storage contents, maybe is not a json file.');
    stderr.writeln(e);
    return _initEmpty(storageFile);
  }
}

SimpleStoreImpl _initEmpty(File file) {
  // init a new empty json file.
  file.writeAsStringSync('{}');
  return SimpleStoreImpl(file, <String, Object>{});
}

/// SimpleStore implementation use file to store data.
class SimpleStoreImpl implements SimpleStore {
  final File _storageFile;
  final Map<String, Object> _storage;

  SimpleStoreImpl(this._storageFile, this._storage);

  @override
  int get length => _storage.length;

  @override
  void clear() {
    _storage.clear();
    _saveFile();
  }

  @override
  T? get<T>(String key) {
    return _storage[key] as T?;
  }

  @override
  void set(String key, Object value) {
    _storage[key] = value;
    _saveFile();
  }

  @override
  String? key(int index) {
    return _storage.keys.elementAt(index);
  }

  @override
  bool exists(String key) => _storage.containsKey(key);

  @override
  void remove(String key) {
    _storage.remove(key);
    _saveFile();
  }

  void _saveFile() {
    _storageFile.writeAsStringSync(jsonEncode(_storage));
  }
}
