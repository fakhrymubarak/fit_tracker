import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      const String urlToCheck = 'www.google.com';

      if (kIsWeb) {
        final result = await http.get(Uri.parse(urlToCheck));
        if (result.statusCode == 200) {
          return true;
        }
      } else {
        final result = await InternetAddress.lookup(urlToCheck);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
