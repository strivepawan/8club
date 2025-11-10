import 'package:flick_tv_ott/core/service_locator/service_locator.dart' as di;
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  di.init();
  runApp(const MyApp());
}