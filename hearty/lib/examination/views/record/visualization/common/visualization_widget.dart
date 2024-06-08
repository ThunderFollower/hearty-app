import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/utils.dart';

/// An abstract class for widgets that visualize audio data.
///
/// Provides a common structure for widgets displaying audio waveforms or
/// spectrograms.
abstract class VisualizationWidget extends ConsumerStatefulWidget {
  /// Initializes visualization widget properties.
  const VisualizationWidget({
    super.key,
    required this.width,
    required this.recordId,
    required this.duration,
  });

  /// Widget width.
  final double width;

  /// Identifier for the associated audio record.
  final String recordId;

  /// Audio duration.
  final Duration duration;

  double timestampToPixels(double timestamp) => normalizedTimestampToPixels(
        timestamp,
        duration: duration,
        size: width,
      );
}
