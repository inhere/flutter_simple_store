# SimpleStore

A simple local storage for Flutter.

- Support all platforms.
- Value support: `num`(`int`, `double`), `bool`, `String`, `List`, `Map`, `Object`

> Github: https://github.com/inhere/flutter_simple_store

## Install

```yaml
dependencies:
  simple_store: ^0.1.0
``` 

## Usage

```dart
import 'package:simple_store/simple_store.dart';

void main() async {
  WidgetsFlutterBinding. ensureInitialized();

  // Initialize the store.
  await initSimpleStore('my-app.json');

  simpleStore.setItem('key', 'value');
  // Will print "value" after app reload as well.
  print(simpleStore.getItem('key'));
}
```

## Interface

```dart
abstract interface class SimpleStore {
  /// The number of key/value pairs in the storage.
  int get length;

  /// Returns the name of the nth key in the storage.
  String? key(int index);

  /// Returns true if the given key exists in the storage.
  bool exists(String key);

  /// Returns the current value associated with the given key.
  T? get<T>(String key);

  /// Sets value for the given key.
  void set(String key, Object value);

  /// Removes the key/value pair with the given key from the storage.
  void remove(String key);

  /// Clears all key/value pairs in the storage.
  void clear();
}
```

## Refers

- https://github.com/lesnitsky/flutter_localstorage
- https://github.com/chuyentt/localstore

## License

MIT
