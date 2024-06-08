import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      final app = await App.create();
      runApp(app);
    },
    App.reportError,
  );
}
