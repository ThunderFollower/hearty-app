import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../record/index.dart';
import 'record_state.dart';

abstract class RecordController extends StateNotifier<RecordState> {
  RecordController(super.state);

  void dismiss();
  void setFilter(Filters filter);
  void toggleMode();
  void togglePlaying();
  void toggleSpeed();
  void onScaleStart(ScaleStartDetails event);
  void onScaleUpdate(ScaleUpdateDetails event);
  void onScaleEnd(ScaleEndDetails event);
  void onHorizontalDragDown(DragDownDetails event);
  void onHorizontalDragUpdate(DragUpdateDetails event);
  void onHorizontalDragEnd(DragEndDetails event);
  void onHorizontalDragCancel();
  void delete();
  void recordAgain();
}
