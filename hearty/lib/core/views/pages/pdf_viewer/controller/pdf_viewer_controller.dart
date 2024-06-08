import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pdf_viewer_state.dart';

/// An abstract controller for managing the state and interactions of a PDF viewer.
abstract class PDFViewerController implements StateNotifier<PDFViewerState> {
  /// Handles interactions with links in the PDF document.
  void handleLink(String? uri);

  /// Handles general errors that occur in the PDF viewer.
  void handleError(dynamic error);

  /// Handles errors that occur on specific pages of the PDF document.
  void handlePageError(int? page, dynamic error);
}
