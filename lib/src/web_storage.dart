// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';

import 'package:web/web.dart' show window;
import 'base.dart';

/// init storage manager in web environment.
Future<SimpleStore> init(String _) async {
  return SimpleStoreImpl();
}

/// SimpleStoreImpl in web environment.
final class SimpleStoreImpl implements SimpleStore {
  @override
  int get length => window.localStorage.length;

  @override
  void clear() => window.localStorage.clear();

  @override
  String? key(int index) => window.localStorage.key(index);

  @override
  T? get<T>(String key) {
    var str = window.localStorage.getItem(key);

    if (str != null) {
      // check is json string
      if (str.isJsonString) {
        return jsonDecode(str) as T;
      }
      return str as T;
    }

    return null;
  }

  @override
  void set(String key, Object value) {
    // check value is basic type
    if (value is String || value is num || value is bool) {
      window.localStorage.setItem(key, value.toString());
      return;
    }

    window.localStorage.setItem(key, jsonEncode(value));
  }

  @override
  bool exists(String key) => window.localStorage.getItem(key) != null;

  @override
  void remove(String key) => window.localStorage.removeItem(key);
}

extension StringExtension on String {
  bool get isJsonString {
    if (startsWith('{')) {
      return endsWith('}');
    }
    return startsWith('[') && endsWith(']');
  }
}
