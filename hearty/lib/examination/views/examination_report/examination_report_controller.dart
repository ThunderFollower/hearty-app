import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'examination_report_state.dart';

/// Defines a contract for a controller that handles the actions and state
/// of an examination report.
abstract class ExaminationReportController
    extends StateNotifier<ExaminationReportState> {
  /// Creates a [ExaminationReportController] with an initial [state].
  ExaminationReportController(super.state);

  /// Shares the current examination report.
  void share();

  /// Dismisses the examination report page.
  void dismiss();

  /// Opens the related guide for the examination report.
  void openGuide();
}
