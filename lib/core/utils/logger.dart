import 'package:flutter/foundation.dart';

void appLog(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}