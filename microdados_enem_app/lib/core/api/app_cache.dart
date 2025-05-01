import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:provider/provider.dart';

class AppCache {
  final LocalStorage cache;
  final String key;

  AppCache({required BuildContext context, required String key})
    : this.cache = Provider.of<LocalStorage>(context, listen: false),
      this.key = '${StorageKeys.cachePrefix}$key';

  Future setEntry(String value) async {
    await cache.setString('${StorageKeys.cachePrefix}${this.key}', value);
  }

  Map<String, dynamic>? getEntry() {
    String value = cache.getString('${StorageKeys.cachePrefix}${this.key}', '');

    if (value.isEmpty) return null;

    return jsonDecode(value) as Map<String, dynamic>;
  }
}
