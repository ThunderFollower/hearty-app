import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../common/common.dart';
import 'pdf_viewer_widget.dart';

/// A widget for displaying PDF documents within a standard page layout.
///
/// This widget extends `FoundationPage` to include a `PDFViewerWidget`.
/// It allows for customizable app bar elements and supports loading PDFs
/// from a file path or directly from binary data.
class PDFViewerPage extends StatelessWidget {
  /// Creates a [PDFViewerPage].
  ///
  /// Accepts parameters for app bar customization and PDF source.
  /// Only one of [filePath] or [pdfData] should be provided.
  ///
  /// Allows specifying an app bar title, a custom widget for the title,
  /// a leading widget, an icon for dismissal, and a body widget.
  /// Only one of [title] or [titleText] should be provided, and similarly,
  /// only one of [leading] or [dismissIcon] should be provided.
  const PDFViewerPage({
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.dismissIcon,
    this.filePath,
    this.pdfData,
  })  : assert(title == null || titleText == null),
        assert(leading == null || dismissIcon == null),
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

  /// A widget to be placed in the leading position of the app bar.
  ///
  /// If non-null, this widget is displayed as the leading widget in the app bar.
  /// It takes precedence over [dismissIcon]. Only one of [leading] or
  /// [dismissIcon] should be provided.
  final Widget? leading;

  /// An icon to be used for a dismiss action in the leading position of the app bar.
  ///
  /// If [leading] is null and this is provided, an `IconButton` with [dismissIcon]
  /// is displayed as the leading widget. The button triggers the dismiss action
  /// defined in [FoundationPageController]. Only one of [leading] or
  /// [dismissIcon] should be provided.
  final IconData? dismissIcon;

  /// The path to a PDF file.
  final String? filePath;

  /// The binary data of a PDF document
  final Uint8List? pdfData;

  @override
  Widget build(BuildContext context) => FoundationPage(
        title: title,
        titleText: titleText,
        leading: leading,
        dismissIcon: dismissIcon,
        child: PDFViewerWidget(filePath: filePath, pdfData: pdfData),
      );
}
