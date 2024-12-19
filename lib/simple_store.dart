import 'src/base.dart';
import 'src/io_storage.dart' if (dart.library.js_util) 'src/web_storage.dart.dart';

export 'src/base.dart';

bool _initialized = false;
late SimpleStore _simpleStore;

/// Initialize the [SimpleStore].
/// - (`!web`) file will save to user app-data directory.
///
/// eg: `await simpleStore.init('app.json')`
Future<void> initSimpleStore(String storeFilename) async {
  if (_initialized) return;
  _simpleStore = await init(storeFilename);
  _initialized = true;
}

/// Get the instance of [SimpleStore].
SimpleStore get simpleStore {
  if (_initialized) return _simpleStore;
  return _simpleStore;
}
