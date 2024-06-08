import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inspection_state.dart';

abstract class InspectionController extends StateNotifier<InspectionState> {
  InspectionController(super.state);

  void play();

  void openReport();

  void delete();
  void recordAgain();
}
