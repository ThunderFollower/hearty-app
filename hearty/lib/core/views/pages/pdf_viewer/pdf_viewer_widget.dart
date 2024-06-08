import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tuple/tuple.dart';

import '../../theme/index.dart';
import 'controller/pdf_viewer_state.dart';
import 'controller/providers.dart';

part 'pdf_viewer_widget_skeleton.dart';

/// A widget to display PDF content, supporting both file paths and binary data.
///
/// Utilizes `flutter_pdfview` for rendering and provides a skeleton loader
/// during the loading state. Works in conjunction with Riverpod for state management.
class PDFViewerWidget extends ConsumerWidget {
  /// Creates a [PDFViewerWidget].
  ///
  /// Either [filePath] or [pdfData] must be provided, but not both.
  const PDFViewerWidget({
    super.key,
    this.filePath,
    this.pdfData,
  }) : assert(filePath == null || pdfData == null);

  /// The initial URL to load.
  final String? filePath;

  /// The binary data of a PDF document
  final Uint8List? pdfData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = pdfViewerStateProvider(Tuple2(filePath, pdfData));
    final state = ref.watch(provider);

    if (_isLoading(state)) return const _Skeleton();

    final controller = ref.watch(provider.notifier);
    return PDFView(
      filePath: state.path,
      pdfData: state.data,
      fitEachPage: false,
      pageFling: false,
      preventLinkNavigation: true,
      onLinkHandler: controller.handleLink,
      onError: controller.handleError,
      onPageError: controller.handlePageError,
    );
  }

  bool _isLoading(PDFViewerState state) =>
      state.path == null && state.data == null;
}
