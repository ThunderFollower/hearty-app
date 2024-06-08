import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides an instance of the [Connectivity].
final connectivityProvider = Provider((_) => Connectivity());
