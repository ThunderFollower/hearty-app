import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

import '../../../../core.dart';
import 'pdf_viewer_controller.dart';
import 'pdf_viewer_controller_adapter.dart';
import 'pdf_viewer_state.dart';

/// Provides an auto-disposable [PDFViewerController] for managing PDF viewer state.
final pdfViewerStateProvider = StateNotifierProvider.family.autoDispose<
    PDFViewerController, PDFViewerState, Tuple2<String?, Uint8List?>>(
  (ref, args) => PDFViewerControllerAdapter(
    const PDFViewerState(),
    filePath: args.item1,
    pdfData: args.item2,
    linkHandler: ref.watch(linkHandlerProvider),
    showErrorNotification: ref.watch(showErrorNotificationProvider),
    cacheManager: ref.watch(cacheManagerProvider),
    logger: Logger(),
  ),
);
