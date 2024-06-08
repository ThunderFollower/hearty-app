import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../use_case/index.dart';

/// A provider that must be overridden to provide a [AsyncCommand] for showing
/// the stethoscope bottom sheet.
final showStethoscopeProvider = Provider.autoDispose<AsyncCommand>(
  (_) => throw UnimplementedError(
    'The `showStethoscopeProvider` must be overridden',
  ),
);
