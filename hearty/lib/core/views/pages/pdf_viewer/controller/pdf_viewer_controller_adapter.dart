import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../utils/utils.dart';
import '../../../../common/link_handler.dart';
import '../../../../use_cases/use_cases.dart';
import '../../../notifications/index.dart';
import 'pdf_viewer_controller.dart';
import 'pdf_viewer_state.dart';

/// An adapter that implements [PDFViewerController] for managing PDF viewer state.
class PDFViewerControllerAdapter extends StateNotifier<PDFViewerState>
    with SubscriptionManager
    implements PDFViewerController {
  /// Create a new [PDFViewerControllerAdapter].
  PDFViewerControllerAdapter(
    PDFViewerState state, {
    String? filePath,
    Uint8List? pdfData,
    required this.linkHandler,
    required this.showErrorNotification,
    required this.cacheManager,
    required this.logger,
  })  : assert(filePath == null || pdfData == null),
        super(state.copyWith(data: pdfData)) {
    if (filePath != null) _loadFile(filePath);
  }

  /// Handles the navigation and action for links within the PDF document.
  final LinkHandler linkHandler;

  /// A use case to display error notifications to the user.
  final ShowNotification showErrorNotification;

  /// Manages the caching of files, used here for caching PDF files.
  final CacheManager cacheManager;

  /// Logs information, warnings, and errors for debugging and analysis.
  final Logger logger;

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  void handleError(dynamic error) {
    logger.e('$this: An error has occurred.', error);
    _showError(error);
  }

  @override
  void handleLink(String? uri) {
    logger.i('$this: Handling link.', uri);
    linkHandler.handleLink(uri);
  }

  @override
  void handlePageError(int? page, dynamic error) {
    logger.e('$this: An error has occurred on page $page.', error);
    _showError(error);
  }

  /// Initiates loading of the PDF file from the given URL.
  void _loadFile(String url) {
    cacheManager
        .getFileStream(url)
        .takeWhile((_) => mounted)
        .whereType<FileInfo>()
        .map((event) => event.file.path)
        .listen(_handleFilePath, onError: _handleFileStreamError)
        .addToList(this);
  }

  /// Updates the state with the local file path of the PDF.
  void _handleFilePath(String path) {
    state = state.copyWith(path: path);
  }

  /// Handles errors during file streaming.
  void _handleFileStreamError(dynamic error, StackTrace stackTrace) {
    logger.e('$this: File operation has failed', error, stackTrace);
    _showError(error);
  }

  /// Displays an error notification.
  void _showError(dynamic error) {
    showErrorNotification.execute(GenericErrorNotification(error));
  }
}
