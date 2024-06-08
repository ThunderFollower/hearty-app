import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sharing_state.dart';

abstract class SharingController extends StateNotifier<SharingState> {
  SharingController(super.state);

  void toggle();

  void share();

  void showDocumentDialog();
}
