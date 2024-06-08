import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import 'api/examination_api_repository.dart';
import 'examination_repository.dart';

final examinationProvider = Provider.autoDispose<ExaminationRepository>(
  (ref) {
    return ExaminationApiRepository(ref.watch(privateApiProvider));
  },
);
