import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_store/simple_store.dart';

main() {
  test('test store', () async {
    final storeFile = '${Directory.current.path}/test/test.json';

    print("storeFile: $storeFile");
    await initSimpleStore(storeFile);
    expect(0, simpleStore.length);

    simpleStore.set('key', 'value');
    simpleStore.set('key2', 234);
    simpleStore.set('key3', true);
    expect(3, simpleStore.length);

    expect('value', simpleStore.get('key'));
    expect(234, simpleStore.get('key2'));
    expect(true, simpleStore.get('key3'));

    // remove
    expect(true, simpleStore.exists('key'));
    simpleStore.remove('key');
    expect(false, simpleStore.exists('key'));

    // map
    simpleStore.set('key4', {'name': 'test', 'age': 18});
    expect({'name': 'test', 'age': 18}, simpleStore.get('key4'));

    // list
    simpleStore.set('key5', ['a', 'b', 'c']);
    expect(['a', 'b', 'c'], simpleStore.get('key5'));

    // clear
    simpleStore.clear();
    expect(0, simpleStore.length);
  });
}
