import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';
import 'spectrogram_generator.dart';
import 'spectrogram_generator_impl.dart';

final spectrogramGeneratorProvider =
    Provider.autoDispose<SpectrogramGenerator>((ref) {
  ref.delayDispose();
  return const SpectrogramGeneratorImpl();
});
