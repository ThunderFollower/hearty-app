import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'examination_tile_state.dart';

abstract class ExaminationTileController
    extends StateNotifier<ExaminationTileState> {
  ExaminationTileController(super.state);

  void handleTap();
}
