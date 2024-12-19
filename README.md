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
import 'package:simple_store/ simple_store. dart';

void main() {
  WidgetsFlutterBinding. ensureInitialized();

  initSimpleStore('my-app.json');
  simpleStore.setItem('key', 'value');

  // Will print "value" after app reload as well.
  print(simpleStore.getItem('key'));
}
```

## Refers

- https://github.com/lesnitsky/flutter_localstorage
- https://github.com/chuyentt/localstore

## License

MIT
