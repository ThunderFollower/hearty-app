import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The state for the landing page.
class LandingState {
  /// Constructs an instance of [LandingState].
  ///
  /// If [canOpenStethoscope] is not provided, it defaults to
  /// `const AsyncLoading<bool>()`.
  const LandingState({
    this.canOpenStethoscope = const AsyncLoading<bool>(),
  });

  /// Indicates if the stethoscope can be opened.
  final AsyncValue<bool> canOpenStethoscope;

  /// Returns a new [LandingState] instance with updated [canOpenStethoscope]
  /// value.
  ///
  /// If [canOpenStethoscope] is not provided, the value from the existing
  /// instance is used.
  LandingState copyWith({
    AsyncValue<bool>? canOpenStethoscope,
  }) =>
      LandingState(
        canOpenStethoscope: canOpenStethoscope ?? this.canOpenStethoscope,
      );
}
