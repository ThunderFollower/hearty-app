import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'record_tile_state.dart';

abstract class RecordTileController extends StateNotifier<RecordTileState> {
  RecordTileController(super.state);

  void openRecordReport();
}
