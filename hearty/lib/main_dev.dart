import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    final app = await _createApp();
    runApp(app);
  }, (error, stack) {
    App.reportError(error, stack);
  });
}

Future<Widget> _createApp() async {
  final app = await App.create();
  return Directionality(
    textDirection: ui.TextDirection.ltr,
    child: app,
  );
}
