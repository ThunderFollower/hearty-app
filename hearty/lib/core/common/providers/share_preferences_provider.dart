import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider to fetch an asynchronous instance of SharedPreferences.
final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);
