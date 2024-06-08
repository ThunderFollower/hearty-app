import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/index.dart';
import 'pdf_viewer_page.dart';

part 'pdf_viewer_sheet_layout.dart';

class PdfViewerSheet extends ConsumerWidget {
  /// Creates a [PdfViewerSheet].
  ///
  /// Accepts parameters for app bar customization and PDF source.
  /// Only one of [filePath] or [pdfData] should be provided.
  ///
  /// Allows specifying an app bar title, a custom widget for the title,
  /// a leading widget, an icon for dismissal, and a body widget.
  /// Only one of [title] or [titleText] should be provided.
  const PdfViewerSheet({
    super.key,
    this.title,
    this.titleText,
    this.filePath,
    this.pdfData,
  })  : assert(title == null || titleText == null),
        assert(filePath != null || pdfData != null),
        assert(filePath == null || pdfData == null);

  /// The widget to be used as the title in the app bar.
  ///
  /// If non-null, this widget is displayed as the title. This takes precedence
  /// over [titleText]. Only one of [title] or [titleText] should be provided.
  final Widget? title;

  /// A text string to be used as the title in the app bar.
  ///
  /// If [title] is null and this is provided, [titleText] is displayed as a
  /// simple text title. Only one of [title] or [titleText] should be provided.
  final String? titleText;

  /// The path to a PDF file.
  final String? filePath;

  /// The binary data of a PDF document
  final Uint8List? pdfData;

  static const _minChildSize = 0.95;
  static const _initialChildSize = 1.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = PDFViewerPage(
      title: title,
      titleText: titleText,
      dismissIcon: AppIcons.close,
      filePath: filePath,
      pdfData: pdfData,
    );

    return wrap(page);
  }

  /// Wraps the given [page] in a draggable scrollable sheet.
  Widget wrap(Widget page) => DraggableScrollableSheet(
        minChildSize: _minChildSize,
        initialChildSize: _initialChildSize,
        builder: (_, __) => _Layout(child: page),
      );
}
