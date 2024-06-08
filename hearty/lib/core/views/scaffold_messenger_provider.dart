import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final scaffoldMessengerProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
  (ref) => scaffoldMessengerKey,
);
